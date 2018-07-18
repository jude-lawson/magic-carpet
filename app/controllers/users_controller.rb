class UsersController < ApplicationController
  def create
    user = User.create(lyft_token: request.env['omniauth.auth']['access_token'])
    redirect_to edit_user_path(user)
  end

  def edit
    user = User.find(params[:id])
    lyft_service = LyftService.new(user)
    user_info = lyft_service.profile_info
    user.update(
      first_name: user_info[:first_name],
      last_name: user_info[:last_name]
    )
  end
end
