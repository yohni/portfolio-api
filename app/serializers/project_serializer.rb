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
      user_id: project.user_id,
      created_at: project.created_at,
      updated_at: project.updated_at
    }
  end
end
