Rails.application.routes.draw do
  post '/api/v1/adventures', to: 'adventures#create'
  get '/auth/lyft', as: :lyft_login
  get '/auth/lyft/callback', to: 'users#create'
  namespace :lyft do
    post '/rides/:id', to: 'adventures#update'
  end

  post '/lyft' => 'webhooks#receive', as: :receive_webhooks
end
