Rails.application.routes.draw do
<<<<<<< HEAD
=======
  post '/api/v1/adventures', to: 'adventures#create'
>>>>>>> Adds lyft_service#call_ride method and test that stubs out the API call
  get '/auth/lyft', as: :lyft_login
  get '/auth/lyft/callback', to: 'users#create'
  resources :users, only: [:edit]
end
