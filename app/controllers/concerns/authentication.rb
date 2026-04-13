module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private


    def require_authentication
      token = extract_bearer_token
      session = token && Session.find_by(token: token)

      is_expired = session&.expired?

      if session && !is_expired
        Current.session = session
      elsif is_expired
        session&.destroy
        render json: { error: "Session expired" }, status: :unauthorized
      else
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end

    def extract_bearer_token
      request.headers["Authorization"]&.delete_prefix("Bearer ")
    end
end
