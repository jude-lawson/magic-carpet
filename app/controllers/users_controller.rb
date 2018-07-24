class UsersController < ApplicationController
  # skip_before_action :authenticate!

  def create
    lyft_token = request.env['omniauth.auth']['access_token']
    lyft_refresh_token = request.env['omniauth.auth']['refresh_token']
    lyft_omniauth_service = LyftOmniauthService.new(lyft_token, lyft_refresh_token)
    user_info = lyft_omniauth_service.profile_info
    User.create(
      lyft_id: user_info[:id],
      first_name: user_info[:first_name],
      last_name: user_info[:last_name],
      lyft_token: lyft_token,
      lyft_refresh_token: lyft_refresh_token
    )
  end
end
