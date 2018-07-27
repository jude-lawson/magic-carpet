class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate!

  def create
    keys = JsonWebToken.decode(request.headers[:payload])
    user = User.create!
    render json: user
  end
end