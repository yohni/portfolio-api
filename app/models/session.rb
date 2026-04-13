class Session < ApplicationRecord
  belongs_to :user
  before_create do
    self.token = SecureRandom.urlsafe_base64(32)
    self.expires_at = 7.days.from_now
  end

  
  validates :user_agent, presence: true
  validates :ip_address, presence: true

  def expired?
    expires_at.nil? || expires_at < Time.current
  end
end
