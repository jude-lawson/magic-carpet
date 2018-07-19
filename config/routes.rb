Rails.application.routes.draw do
  post '/api/v1/adventures', to: 'adventures#create'
<<<<<<< HEAD
=======
  get '/auth/lyft', as: :lyft_login
  get '/auth/lyft/callback', to: 'users#create'
  resources :users, only: [:edit]
>>>>>>> 6498d1c334d8b5566be3944047746059f5bb8282
end
