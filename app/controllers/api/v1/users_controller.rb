class Api::V1::UsersController < ApplicationController
  allow_unauthenticated_access only: [ :create ]

  def create
    user = User.new(user_params)
    if user.save
      render json: { data: { id: user.id, email: user.email_address, username: user.username } }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def me
    render json: { data: UserSerializer.one(current_user) }
  end

  private

  def user_params
    params.permit(:email_address, :password, :password_confirmation, :username)
  end
end
