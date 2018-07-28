class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate!

  def create
    keys = JsonWebToken.decode(request.headers["payload"])
    require'pry';binding.pry
    user = User.create!
    require'pry';binding.pry
    render json: user
  end
end