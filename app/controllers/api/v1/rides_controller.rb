class Api::V1::RidesController < ApplicationController
  skip_before_action :authenticate!

  def create
    response = LyftService.call_ride(headers['origin'], headers['destination'], headers['lyft_token'], headers['cost_token'])
    render json: response
    # mock_info = File.read('fixtures/lyft_call_response.json')
    # render json: mock_info
  end

  def edit
    response = LyftService.cancel_ride_request(headers['ride_id'], headers['lyft_token'])
    render json: response
    # mock_info = File.read('fixtures/lyft_cancel_response_failure.json')
    # render json: mock_info
  end

  def destroy
    response = LyftService.cancel_ride(headers['ride_id'], headers['cost_token'], headers['lyft_token'])
    render json: response
    # render json: ''
  end
end