class Api::Beta::UsersController < ApplicationController
  skip_before_action :authenticate!

  def create
    keys = JsonWebToken.decode(request.headers["payload"])
    if keys[:token]
      user = User.create!
      response.headers['Authorization'] = payload(user)
    else 
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
