Rails.application.routes.draw do
  resource :session, only: [ :create, :destroy ]      # login / logout
  resources :users, only: [ :create ] do                # signup
    get :me, on: :collection
  end

  namespace :api do
    namespace :v1 do
      # Plural `resources` adds GET /api/v1/projects → #index.
      # Singular `resource :projects` does not — GET /projects would hit #show instead.
      resources :projects, only: %i[index show create update destroy]
      resources :experiences, only: %i[index create show update destroy]
      resources :posts, only: %i[index create show update destroy]


      resources :users, only: [], param: :username do
        resources :projects, only: %i[index show], controller: "users/projects"
      end
    end
  end
end
