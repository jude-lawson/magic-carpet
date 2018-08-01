class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate!

  def create
    keys = JsonWebToken.decode(request.headers["payload"])
    binding.pry
    if keys[:token]
      user = User.create!
      response.headers['Authorization'] = payload(user)
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
