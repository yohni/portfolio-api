# Plain JSON helper (not active_model_serializers — that gem is not in the Gemfile).
class ProjectSerializer
  def self.collection(projects)
    projects.map { |project| one(project) }
  end

  def self.one(project)
    {
      id: project.id,
      title: project.title,
      description: project.description,
      tech_stack: project.tech_stack,
      live_url: project.live_url,
      github_url: project.github_url,
      thumbnail_url: project.thumbnail_url,
      position: project.position,
      featured: project.featured,
      user_id: project.user_id,
      created_at: project.created_at,
      updated_at: project.updated_at
    }
  end
end
