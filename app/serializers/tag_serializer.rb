# Plain JSON helper (not active_model_serializers — that gem is not in the Gemfile).
class TagSerializer
  def self.one(tag)
    {
      id: tag.id,
      name: tag.name,
      slug: tag.slug
    }
  end

  def self.collection(tags)
    tags.map { |tag| one(tag) }
  end
end
