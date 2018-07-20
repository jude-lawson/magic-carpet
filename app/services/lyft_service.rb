class LyftService

  def initialize(user)
    @user = user
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
                          end_lng: destination[:lng],
                          ride_type: 'lyft'
                        }
    end
    min_price = JSON.parse(response.body)['cost_estimates'].first['estimated_cost_cents_min']
    max_price = JSON.parse(response.body)['cost_estimates'].first['estimated_cost_cents_max']
    { "min_cost": min_price, "max_cost": max_price }
  end
end
