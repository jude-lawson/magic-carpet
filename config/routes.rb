Rails.application.routes.draw do
  post '/api/v1/adventures', to: 'adventures#create'
  get '/auth/lyft', as: :lyft_login
  get '/auth/lyft/callback', to: 'users#create'

  namespace :api do
    namespace :v1 do
      get '/profile', to: 'users#show'
    end
  end

  resources :users, only: [:edit]
end
