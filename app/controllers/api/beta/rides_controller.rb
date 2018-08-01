class Api::Beta::RidesController < ApplicationController

  def create
    lyft_service = FakeLyftService.new(@user)
    call_details = JSON.parse(request.body.string, symbolize_names: true)
    response = lyft_service.call_ride(headers['origin'], headers['destination'], headers['cost_token'])
    render json: response
  end

  def cancel
    lyft_service = FakeLyftService.new(@user)
    ride_id =  JSON.parse(request.body.string, symbolize_names: true)
    response = lyft_service.cancel_ride_request(ride_id)
    render json: response
    # mock_info = File.read('fixtures/lyft_cancel_response_failure.json')
    # render json: mock_info
  end

  def destroy
    lyft_service = FakeLyftService.new(@user)
    ride_id = JSON.parse(request.body.string, symbolize_names: true)
    response = LyftService.confirm_cancel(ride_id, token)
    render json: response
  end
end
