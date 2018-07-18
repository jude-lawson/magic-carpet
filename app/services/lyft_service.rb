class LyftService

  def initialize(user)
    @user = user
  end

  def profile_info
    get_json('https://api.lyft.com/v1/profile')
  end

  private

  def get_json(url)
    response = Faraday.get(url, nil, authorization: "Bearer #{@user.lyft_token}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
