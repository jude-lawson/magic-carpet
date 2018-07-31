require 'rails_helper'

describe 'Lyft Service' do
  describe '#call_ride' do
    it 'calls ride and returns ride information' do
      user = create(:user)
      origin = { lat: 37.77663, lng: -122.39227 }
      destination = { lat: 37.771, lng: -122.39123 }

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

      actual = LyftService.call_ride(origin, destination)

      expect(actual).to be_a(String)
      expect(actual).to include('status')
      expect(actual).to include('passenger')
      expect(actual).to include('987')
    end
  end

  describe '#get_estimate' do
    it 'returns an cost min and cost max for ride' do
      user = create(:user)
      origin = { lat: 37.77663, lng: -122.39227 }
      destination = { lat: 37.771, lng: -122.39123 }

      stub_request(:get, "https://api.lyft.com/v1/cost?end_lat=37.771&end_lng=-122.39123&ride_type=lyft&start_lat=37.77663&start_lng=-122.39227").
                    with(
                      headers: {
                        'Accept': '*/*',
                        'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                        'Authorization': 'Bearer',
                        'User-Agent': 'Faraday v0.12.2'
                      }
                    ).
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

      actual = LyftService.get_estimate(origin, destination)

      expect(actual[:min_cost]).to eq(1052)
      expect(actual[:max_cost]).to eq(1755)
    end
  end

  describe '#cancel_ride_request' do
    context 'No cancellation fee incurred' do
      it 'cancels the ride and returns 204 status' do
        user = create(:user)
        ride_id = 1
        lyft_token = 'cuhf08214inf[rc09efn4j0c3r9enci]ojfejnoih42'

        stub_request(:post, "https://api.lyft.com/v1/rides/#{ride_id}/cancel").
                      with(
                        headers: {
                          'Content-Type': 'application/json',
                          'Authorization': "Bearer #{lyft_token}",
                          'User-Agent': 'Faraday v0.12.2'
                        }
                      ).
                      to_return(
                                status: 204,
                                body: '',
                                headers: {}
                               )

        actual = LyftService.cancel_ride_request(ride_id, lyft_token)

        expect(actual).to eq('')
      end
    end

    context 'A cancellation fee is incurred' do
      it 'returns the cancellation fee amount and cancellation token' do
        user = create(:user)
        ride_id = 1
        lyft_token = '849hrfnh928hi3ind20894jrnfu938h04tfr'

        stub_request(:post, "https://api.lyft.com/v1/rides/#{ride_id}/cancel").
                      with(
                        headers: {
                          'Content-Type': 'application/json',
                          'Authorization':  "Bearer #{lyft_token}",
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

        actual = LyftService.cancel_ride_request(ride_id, lyft_token)

        parsed_actual = JSON.parse(actual)

        expect(parsed_actual['amount']).to eq(500)
        expect(parsed_actual['token']).to eq('656a91d')
      end
    end
  end

  describe '#cancel_ride' do
    it 'cancels the ride and returns 204 status' do
      user = create(:user)
      ride_id = 1
      cost_token = 'nrfie4idmd'
      lyft_token = 'fu498rnfrcv9r0834h2pinr34fcg04j2fmoenob'

      stub_request(:post, "https://api.lyft.com/v1/rides/#{ride_id}/cancel").
                    with(
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization':  "Bearer #{lyft_token}",
                        'User-Agent': 'Faraday v0.12.2'
                      },
                      body: {
                        'cancel_confirmation_token': cost_token
                      }
                    ).
                    to_return(
                              status: 204,
                              body: '',
                              headers: {}
                             )

      actual = LyftService.cancel_ride(ride_id, cost_token, lyft_token)

      expect(actual).to eq('')
    end
  end
end
