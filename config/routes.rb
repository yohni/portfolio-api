Rails.application.routes.draw do
  get "projects/create"
  get "users/create"
  resource :session, only: [ :create, :destroy ]      # login / logout
  resources :users, only: [ :create ]                  # signup

  namespace :api do
    namespace :v1 do
      # Plural `resources` adds GET /api/v1/projects → #index.
      # Singular `resource :projects` does not — GET /projects would hit #show instead.
      resources :projects, only: %i[index show create]
    end
  end
end
