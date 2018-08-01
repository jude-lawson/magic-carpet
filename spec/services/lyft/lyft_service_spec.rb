require 'rails_helper'

describe 'Lyft Service' do
  describe '#call_ride' do
    it 'calls ride and returns ride information' do
      user = User.create
      origin = { lat: 37.77663, lng: -122.39227 }
      destination = { lat: 37.771, lng: -122.39123 }
      cost_token = {cost_token: 'uhe4h8r92i34fcj938'}

      stub_request(:post, 'https://api.lyft.com/v1/rides').
                    with(
                      headers: {
                       'Accept': '*/*',
                       'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                       'Authorization': 'Bearer',
                       'User-Agent': 'Faraday v0.12.2',
                       'Content-Type': 'application/json'
                        }).
                    to_return(
                      status: 201,
                      body: {
                        status: 'pending',
                        ride_id: '123',
                        ride_type: 'lyft',
                        passenger: {
                          rating: '5',
                          first_name: 'John',
                          last_name: 'Smith',
                          image_url: 'https://lyft.com/photo.jpg',
                          user_id: '987'
                        },
                        destination: {
                          lat: 37.77663,
                          lng: -122.39123,
                          eta_seconds: 'null',
                          address: 'Mission Bay Boulevard North'
                        },
                        origin: {
                          lat: 37.771,
                          lng: -122.39227,
                          address: 'null'
                        }
                      }.to_json,
                      headers: {}
                    )

      lyft_service = LyftService.new(user)
      actual = lyft_service.call_ride(origin, destination, cost_token)

      expect(actual['status']).to eq("pending")
      expect(actual['ride_id']).to eq("123")
      expect(actual['ride_type']).to eq("lyft")
    end
  end

  describe '#get_estimate' do
    it 'returns an cost min and cost max for ride' do
      user = User.create
      origin = { latitude: 37.77663, longitude: -122.39227 }
      destination = { latitude: 37.771, longitude: -122.39123 }

      stub_request(:get, "https://api.lyft.com/v1/cost?end_lat=37.771&end_lng=-122.39123&ride_type=lyft&start_lat=37.77663&start_lng=-122.39227").
          with(
            headers: {
                     'Accept'=>'*/*',
                     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                     'Content-Type'=>'application/json',
                     'User-Agent'=>'Faraday v0.12.2'
                      }).
                    to_return(status: 200,
                              body: '{
                                "cost_estimates": [
                                  {
                                      "currency": "USD",
                                      "ride_type": "lyft",
                                      "display_name": "Lyft",
                                      "primetime_percentage": "25%",
                                      "primetime_confirmation_token": null,
                                      "cost_token": null,
                                      "price_quote_id": "17f87a53f3917dcc0cfc2a74b7bf267e9b97d37539a1f9b2310a81f00bc09ca4",
                                      "is_valid_estimate": true,
                                      "estimated_duration_seconds": 1626,
                                      "estimated_distance_miles": 5.52,
                                      "estimated_cost_cents_min": 1052,
                                      "estimated_cost_cents_max": 1755,
                                      "can_request_ride": true
                                  }
                                ]
                              }',
                              headers: {}
                             )

      lyft_service = LyftService.new(user)
      actual = lyft_service.get_estimate(origin, destination)

      expect(actual[:min_cost]).to eq(1052)
      expect(actual[:max_cost]).to eq(1755)
    end
  end

  describe '#cancel_ride' do
    context 'No cancellation fee incurred' do
      it 'cancels the ride and returns cancel confirmation' do
        user = User.create
        ride_id = 1

        stub_request(:post, "https://api.lyft.com/v1/rides/#{ride_id}/cancel").
                      with(
                        headers: {
                          'Content-Type': 'application/json',
                          'Authorization': 'Bearer',
                          'User-Agent': 'Faraday v0.12.2'
                        }
                      ).
                      to_return(
                                status: 204,
                                body: 'No Content',
                                headers: {}
                               )

        lyft_service = LyftService.new(user)
        actual = lyft_service.cancel_ride_request(ride_id)

        expect(actual.body).to eq('')
      end
    end

    context 'A cancellation fee is incurred' do
      it 'returns the cancellation fee amount and cancellation token' do
        user = User.create
        ride_id = 1

        stub_request(:post, "https://api.lyft.com/v1/rides/#{ride_id}/cancel").
                      with(
                        headers: {
                          'Content-Type': 'application/json',
                          'Authorization': 'Bearer',
                          'User-Agent': 'Faraday v0.12.2'
                        }
                      ).
                      to_return(
                        status: 400,
                        body: '{
                                "error": "cancel_confirmation_required",
                                "error_detail": [
                                  {
                                    "cancel_confirmation": "a valid cancel_confirmation_token is required to cancel a ride"
                                  }
                                ],
                                "amount": 500,
                                "currency": "USD",
                                "token": "656a91d",
                                "token_duration": 60
                              }',
                        headers: {
                          'Content-Type': 'application/json'
                        }
                      )

        lyft_service = LyftService.new(user)
        actual = lyft_service.cancel_ride_request(ride_id)
        parsed = JSON.parse(actual.body)

        expect(parsed['error']).to eq('cancel_confirmation_required')
        expect(parsed['amount']).to eq(500)
        expect(parsed['token']).to eq('656a91d')
      end
    end
  end
end
