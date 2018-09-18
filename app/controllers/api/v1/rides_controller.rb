class Api::V1::RidesController < ApplicationController

  def create
    lyft_service = LyftService.new(@user)
    call_details = JSON.parse(request.body.string, symbolize_names: true)
    response = lyft_service.call_ride(headers['origin'], headers['destination'], headers['cost_token'])
    render json: response
  end

  def cancel
    lyft_service = LyftService.new(@user)
    ride_id =  JSON.parse(request.body.string, symbolize_names: true)
    response = lyft_service.cancel_ride_request(ride_id)
    render json: response
  end

  def destroy
    # response = LyftService.cancel_ride(headers['ride_id'], headers['cost_token'])
    lyft_service = LyftService.new(@user)
    ride_id = JSON.parse(request.body.string, symbolize_names: true)
    response = LyftService.confirm_cancel(ride_id, token)
    render json: response
    # render json: ''
  end
end
