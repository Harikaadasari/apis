Rails.application.routes.draw do
  post '/signup', to: 'users#signup'
  post '/login', to: 'users#login'
  resources :projects, only: [:create, :index, :show, :destroy, :update] do 

    resources :collections do 
        resources :apis, only: [:create, :index, :show, :destroy, :update]
  end
end

end 