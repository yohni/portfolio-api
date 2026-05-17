class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  enum :status, { draft: "draft", published: "published" }, default: :draft, validate: true

  def publish
    return true if published?

    update(status: :published, published_at: Time.current)
  end

  def unpublish
    return true if draft?

    update(status: :draft, published_at: nil)
  end
end
