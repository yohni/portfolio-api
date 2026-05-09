class ApplicationController < ActionController::API
  include Authentication
  include SetActiveStorageUrl

  private

  def current_user
    Current.session&.user
  end
end
