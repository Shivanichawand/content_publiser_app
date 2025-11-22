Rails.application.routes.draw do
  post '/signup', to: 'auth#signup'
  post '/login', to: 'auth#login'

  resources :publications
  resources :publications, only: [:index, :show, :create, :update, :destroy]
end
