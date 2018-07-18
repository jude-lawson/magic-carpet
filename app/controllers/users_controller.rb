class UsersController < ApplicationController
  def create
    lyft_service = LyftService.new(request.env['omniauth.auth']['access_token'], request.env['omniauth.auth']['refresh_token'])
    user_info = lyft_service.profile_info
    User.create(
      lyft_id: user_info[:id],
      lyft_token: request.env['omniauth.auth']['access_token'],
      lyft_refresh_token: request.env['omniauth.auth']['refresh_token'],
      first_name: user_info[:first_name],
      last_name: user_info[:last_name]
    )
  end

  def edit
    user = User.find(params[:id])
    user.update(
      lyft_token: request.env['omniauth.auth']['access_token'],
    )
  end
end
