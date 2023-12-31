# config/routes.rb
Rails.application.routes.draw do
  post '/signup', to: 'users#signup'
  post '/login', to: 'users#login'

  resources :users, only: [:show] do
    resources :projects, only: [:create, :index] # Nested route for projects under users
    resources :collections, only: [:create, :index, :show, :destroy] do
      resources :apis, only: [:create] # Nested route for creating an API under a collection
    end
    post 'create_project', to: 'users#create_project' # New route for create_project action
  end

  resources :projects, only: [:show, :update, :destroy] do
    resources :collections, only: [:create, :index, :show, :destroy] # Nested route for collections under projects
  end

  resources :collections do
    resources :apis, only: [:create, :index, :show, :destroy]
    get 'all_apis', on: :collection # Use `:collection` instead of `:member`
  end

  # Route for creating an API under a collection without nesting under collections
  post '/projects/:project_id/collections/:collection_id/apis', to: 'apis#create'

  # Route for showing the details of a single API
  get '/projects/:project_id/collections/:collection_id/apis/:id', to: 'apis#show'

  # Route for dynamically handling user-created paths
  match '/*path', to: 'apis#dynamic_show', via: [:get, :post]
  
end
