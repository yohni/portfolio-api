# Plain JSON helper (not active_model_serializers — that gem is not in the Gemfile).
class UserSerializer
  def self.one(user)
    {
      id: user.id,
      email: user.email_address,
      username: user.username
    }
  end
end
