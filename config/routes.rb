Rails.application.routes.draw do
  get '/auth/lyft', as: :lyft_login
  get '/auth/lyft/callback', to: 'users#create'
  resources :users, only: [:edit]
end
