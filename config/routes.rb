Rails.application.routes.draw do
  post '/api/v1/adventures', to: 'adventures#create'
end
