Rails.application.routes.draw do
  post '/api/v1/adventures', to: 'adventures#create'
  get '/auth/lyft', as: :lyft_login
  get '/auth/lyft/callback', to: 'users#create'
  resources :users, only: [:edit]

  namespace :api do
    namespace :v1 do
      post '/rides/new', to: 'rides#create'
      get '/cancel', to: 'rides#edit'

      # Test routes for verifying proper mocking in test environment
      get '/test', to: 'test#index'
      post '/test', to: 'test#create'
    end
  end
end
