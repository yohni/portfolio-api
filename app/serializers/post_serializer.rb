# Plain JSON helper (not active_model_serializers — that gem is not in the Gemfile).
class PostSerializer
  def self.collection(posts)
    posts.map { |post| one(post) }
  end

  def self.one(post)
    {
      id: post.id,
      title: post.title,
      content: post.content,
      cover_image_url: post.cover_image_url,
      status: post.status,
      published_at: post.published_at,
      views_count: post.views_count,
      user_id: post.user_id,
      created_at: post.created_at,
      updated_at: post.updated_at
    }
  end
end
