Rails.application.routes.draw do

  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'

  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'

  delete '/logout' => 'sessions#destroy', as: 'logout'


  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users, only: [] do
        collection do
          get '/exists', action: 'exists?'
        end
      end
    end
  end


  root to: 'site#landing'
end
