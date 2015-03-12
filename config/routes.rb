Rails.application.routes.draw do

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'

  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'

  
  root to: 'site#landing'
end
