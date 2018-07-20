class LyftService

  def initialize(user_token, refresh_token)
    @user_token = user_token
    @refresh_token = refresh_token
  end

  def profile_info
    check_token
    get_json('https://api.lyft.com/v1/profile')
  end

  def renew_token
    conn = Faraday.new(url: 'https://api.lyft.com') do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.basic_auth(ENV['LYFT_CLIENT_ID'], ENV['LYFT_CLIENT_SECRET'])
    end
    response = conn.post('/oauth/token') do |request|
      request.headers['Content-Type'] = 'application/json'
      request.headers['Cache-Control'] = 'no-cache'
      request.body = { grant_type: 'refresh_token', refresh_token: @refresh_token }.to_json
    end
    json_response = JSON.parse(response.body, symbolize_names: true)
    @user_token = json_response[:access_token]
  end

  def call_ride(origin, destination)
    conn = Faraday.new(url: 'https://api.lyft.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
    response = conn.post('/v1/rides') do |request|
      request.headers['Authorization'] = "Bearer #{@user_token}"
      request.headers['Content-Type'] = 'application/json'
      request.body = { ride_type: 'lyft', origin: origin, destination: destination }
    end
    json_response = JSON.parse(response.body, symbolize_names: true)
    @ride_id = json_response[:ride_id]
  end

  def get_estimate(origin, destination)
    conn = Faraday.new(url: 'https://api.lyft.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
    response = conn.get('/v1/cost') do |request|
      request.headers['Authorization'] = "Bearer #{@user_token}"
      request.params = {
                          start_lat: origin[:lat],
                          start_lng: origin[:lng],
                          end_lat: destination[:lat],
                          end_lng: destination[:lng]
                        }
    end
    min_price = JSON.parse(response.body)['cost_estimates'][2]['estimated_cost_cents_min']
    max_price = JSON.parse(response.body)['cost_estimates'][2]['estimated_cost_cents_max']
    actual = { "min_cost": min_price, "max_cost": max_price }
  end

  private

    def check_token
      response = Faraday.get('https://api.lyft.com/v1/profile', nil, authorization: "Bearer #{@user_token}")
      renew_token if @user_token && response.body.empty?
    end

    def get_json(url)
      response = Faraday.get(url, nil, authorization: "Bearer #{@user_token}")
      JSON.parse(response.body, symbolize_names: true)
    end
end
