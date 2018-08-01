Rails.application.routes.draw do
  get '/auth/lyft', as: :lyft_login
  get '/auth/lyft/callback', to: 'users#create'
  resources :users, only: [:edit]

  namespace :api do
    namespace :beta do
      post 'adventures', to: 'adventures#create'
      post 'rides', to: 'rides#create'
      post 'users', to: 'users#create'
      post 'cancel', to: 'rides#cancel'
      post 'confirm', to: 'rides#destroy'

      # Test routes for verifying proper mocking in test environment
      get '/test', to: 'test#index'
      post '/test', to: 'test#create'
    end
    namespace :v1 do
      post 'adventures', to: 'adventures#create'
      post 'rides', to: 'rides#create'
      post 'users', to: 'users#create'
      post 'cancel', to: 'rides#cancel'
      post 'confirm', to: 'rides#destroy'

      # Test routes for verifying proper mocking in test environment
      get '/test', to: 'test#index'
      post '/test', to: 'test#create'
    end
  end
end
