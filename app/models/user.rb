class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :experiences, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :username, with: ->(s) { s.to_s.strip.downcase.parameterize }

  before_validation :assign_username, on: :create

  validates :username, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }

  private

  def assign_username
    return if username.present?

    base = email_address.to_s.split("@").first.to_s.parameterize
    base = "user" if base.blank?
    candidate = base
    suffix = 0
    while User.exists?(username: candidate)
      suffix += 1
      candidate = "#{base}-#{suffix}"
    end
    self.username = candidate
  end
end
