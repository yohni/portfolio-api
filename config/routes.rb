Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :session, only: [ :create, :destroy ]      # login / logout
      resources :users, only: [ :create ], param: :username do # signup
        get :me, on: :collection
        resources :projects, only: %i[index show], controller: "users/projects"
      end

      # Plural `resources` adds GET /api/v1/projects → #index.
      # Singular `resource :projects` does not — GET /projects would hit #show instead.
      resources :projects, only: %i[index show create update destroy]
      resources :experiences, only: %i[index create show update destroy]
      resources :posts, only: %i[index create show update destroy] do
        member do
          patch :publish
          patch :unpublish
        end
      end
      resources :uploads, only: %i[create destroy]
      resources :tags, only: %i[create]
    end
  end
end
