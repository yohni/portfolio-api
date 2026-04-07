# Plain JSON helper (not active_model_serializers — that gem is not in the Gemfile).
class ExperienceSerializer
  def self.collection(experiences)
    experiences.map { |experience| one(experience) }
  end

  def self.one(experience)
    {
      id: experience.id,
      company: experience.company,
      position: experience.position,
      start_date: experience.start_date,
      end_date: experience.end_date,
      current: experience.current,
      role: experience.role,
      description: experience.description,
      location: experience.location,
      user_id: experience.user_id,
      created_at: experience.created_at,
      updated_at: experience.updated_at
    }
  end
end
