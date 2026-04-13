class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [ :create ]


  def create
    if user = User.authenticate_by(session_params)
      session = user.sessions.create!(
        user_agent: request.user_agent,
        ip_address: request.remote_ip,
      )
      render json: { token: session.token, username: user.username, expires_at: session.expires_at }, status: :created
    else
      render json: { error: "Invalid email address or password" }, status: :unauthorized
    end
  end

  def destroy
    Current.session.destroy
    head :no_content
    render json: { message: "Logged Out" }, status: :ok
  end

  def session_params
    params.permit(:email_address, :password)
  end
end
