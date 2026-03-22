class ApplicationController < ActionController::API
  include Authentication

  private

  def current_user
    Current.session&.user
  end
end
