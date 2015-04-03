Rails.application.routes.draw do
  resources :movies, only: [:show, :index]
  resources :users, except: [:new, :edit]
  post '/login', to: 'users#login'
  get '/logout', to: 'users#logout'
end
