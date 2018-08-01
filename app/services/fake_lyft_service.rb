class FakeLyftService

  def initialize(user)
    @user = user
  end

  def call_ride(origin, destination, cost_token)
    call = JSON.parse(File.read("./fixtures/lyft_call_response.json"))
  end

  def get_estimate(origin, destination)
    response = get_cost(origin, destination)
    body = JSON.parse(response.body)["cost_estimates"].first

    min_price = body['estimated_cost_cents_min']
    max_price = body['estimated_cost_cents_max']
    cost_token = body['cost_token']
    { "min_cost": min_price, "max_cost": max_price, "cost_token": cost_token}
  end

  # def cancel_ride(ride_id)
  #   response = cancel_ride_request(ride_id)
  #   status =  204
  #   if status == 204
  #     {message: "Your ride has been cancelled"}
  #   elsif status == 400
  #     cancel_fee = JSON.parse(response)['amount']
  #     cancel_token = JSON.parse(response)['token']
  #     { cancel_fee: cancel_fee, cancel_token: cancel_token, message: "There is a fee involved with cancelling this ride. Would you like to cancel" }
  #   end
  # end
  def cancel_ride_request(ride_id)
    File.read('./fixtures/lyft_cancel_response_failure.json')
  end


  def confirm_cancel(ride_id, token)
    payload = { cancel_confirmation_token: token }
  end

  private
    def conn
      Faraday.new(url: 'https://api.lyft.com') do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_cost(origin, destination)
      conn.get('/v1/cost') do |request|
        request.headers['Content-Type'] = 'application/json'
        request.params = {
          start_lat: origin[:latitude],
          start_lng: origin[:longitude],
          end_lat: destination[:latitude],
          end_lng: destination[:longitude],
          ride_type: 'lyft'
        }
      end
    end
end
