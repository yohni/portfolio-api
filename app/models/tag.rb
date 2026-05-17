class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  normalizes :name, with: ->(n) { n.to_s.strip }
  normalizes :slug, with: ->(s) { s.to_s.strip.downcase.parameterize }

  before_validation :assign_slug, on: :create

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }

  private

  def assign_slug
    return if slug.present?

    base = name.to_s.parameterize
    base = "tag" if base.blank?

    candidate = base
    suffix = 0
    while Tag.exists?(slug: candidate)
      suffix += 1
      candidate = "#{base}-#{suffix}"
    end

    self.slug = candidate
  end
end
