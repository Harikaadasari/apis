Rails.application.routes.draw do
  post '/signup', to: 'users#signup'
  post '/login', to: 'users#login'
  resources :projects, only: [:create, :index, :show, :destroy, :update]
end
