class LyftOmniauthService
  def initialize(user_token, refresh_token)
    @user_token = user_token
    @refresh_token = refresh_token
  end

  def profile_info
    check_token
    get_json('https://api.lyft.com/v1/profile')
  end

  def renew_token
    response = conn.post('/oauth/token') do |request|
      request.headers['Content-Type'] = 'application/json'
      request.headers['Cache-Control'] = 'no-cache'
      request.body = { grant_type: 'refresh_token', refresh_token: @refresh_token }.to_json
    end
    json_response = JSON.parse(response.body, symbolize_names: true)
    @user_token = json_response[:access_token]
  end

  def conn
    Faraday.new(url: 'https://api.lyft.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.basic_auth(ENV['LYFT_CLIENT_ID'], ENV['LYFT_CLIENT_SECRET'])
    end
  end

  private

    def get_json(url)
      response = Faraday.get(url, nil, authorization: "Bearer #{@user_token}")
      JSON.parse(response.body, symbolize_names: true)
    end

    def check_token
      response = Faraday.get('https://api.lyft.com/v1/profile', nil, authorization: "Bearer #{@user_token}")
      renew_token if @user_token && response.body.empty?
    end
end
