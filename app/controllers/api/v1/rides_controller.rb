class Api::V1::RidesController < ApplicationController

  def create
    binding.pry
    lyft_service = LyftService.new(@user)
    call_details = JSON.parse(request.body.string, symbolize_names: true)
    #
    # response = lyft_service.call_ride(headers['origin'], headers['destination'], headers['cost_token'])
    # render json: response
    # mock_info = File.read('fixtures/lyft_call_response.json')
    # render json: mock_info
  end

  def edit
    lyft_service = LyftService.new(@user)
    ride_info =  JSON.parse(request.body.string, symbolize_names: true)
    binding.pry
    response = lyft_service.cancel_ride_request(headers['ride_id'])
    render json: response
    # mock_info = File.read('fixtures/lyft_cancel_response_failure.json')
    # render json: mock_info
  end

  def destroy
    lyft_service = LyftService.new(@user)
    response = LyftService.cancel_ride(headers['ride_id'], headers['cost_token'])
    render json: response
    # render json: ''
  end
end
