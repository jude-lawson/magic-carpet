Rails.application.routes.draw do
  post '/api/v1/adventures', to: 'adventures#create'
  get '/auth/lyft', as: :lyft_login
  get '/auth/lyft/callback', to: 'users#create'
  resources :users, only: [:edit]
end
