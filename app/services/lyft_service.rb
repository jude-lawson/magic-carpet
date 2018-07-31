class LyftService

  def initialize(user)
    @user = user
  end

  def call_ride(origin, destination)
    response = conn.post('/v1/rides') do |request|
      request.headers['Authorization'] = "Bearer #{@user_token}"
      request.headers['Content-Type'] = 'application/json'
      request.body = { ride_type: 'lyft', origin: origin, destination: destination }
    end
    response.body
  end

  def get_estimate(origin, destination)
    response = get_cost(origin, destination)
    min_price = JSON.parse(response.body)['cost_estimates'].first['estimated_cost_cents_min']
    max_price = JSON.parse(response.body)['cost_estimates'].first['estimated_cost_cents_max']
    { "min_cost": min_price, "max_cost": max_price }
  end

  def cancel_ride_request(ride_id)
    response = conn.post("/v1/rides/#{ride_id}/cancel") do |request|
      request.headers['Authorization'] = "Bearer #{@user_token}"
      request.headers['Content-Type'] = 'application/json'
    end
    response.body
  end

  def cancel_ride(ride_id, cost_token)
    response = conn.post("/v1/rides/#{ride_id}/cancel") do |request|
      request.headers['Authorization'] = "Bearer #{@user_token}"
      request.headers['Content-Type'] = 'application/json'
      request.body = { cancel_confirmation_token: cost_token.to_s }.to_json
    end
    response.body
  end

  private
    def conn
      Faraday.new(url: 'https://api.lyft.com') do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_cost(origin, destination)
      conn.get('/v1/cost') do |request|
        request.headers['Authorization'] = "Bearer #{@user_token}"
        request.headers['Content-Type'] = 'application/json'
        request.params = {
          start_lat: origin[:lat],
          start_lng: origin[:lng],
          end_lat: destination[:lat],
          end_lng: destination[:lng],
          ride_type: 'lyft'
        }
      end
    end
end
