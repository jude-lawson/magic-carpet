class Api::V1::RidesController < ApplicationController
  skip_before_action :authenticate!

  def create
    # require 'pry';binding.pry
  # lyft_service = LyftService.new(@user)
    # call_details = JSON.parse(request.body.string, symbolize_names: true)
    # response = lyft_service.call_ride(headers['origin'], headers['destination'], headers['cost_token'])
    response = {
      status: "pending",
      ride_id: "123",
      ride_type: "lyft",
      passenger: {
        rating: "5",
        first_name: "John",
        last_name: "Smith",
        image_url: "https://lyft.com/photo.jpg",
        user_id: "987"
      },
      destination: {
        lat: 37.771,
        lng: -122.39123,
        eta_seconds: nil,
        address: "Mission Bay Boulevard North"
      },
      origin: {
        lat: 37.77663,
        lng: -122.39227,
        address: nil
      }
    }
    render json: response
  end

  def new
    response = {
      error: "cancel_confirmation_required",
      error_detail: [
        {
          cancel_confirmation: "a valid cancel_confirmation_token is required to cancel a ride"
        }
      ],
      amount: 500,
      currency: "USD",
      token: "656a91d",
      token_duration: 60
    }
    render json: response
  end

  def cancel
    require'pry';binding.pry
    lyft_service = LyftService.new(@user)
    ride_id =  JSON.parse(request.body.string, symbolize_names: true)
    response = lyft_service.cancel_ride_request(ride_id)
    render json: response
  end

  def destroy
    # response = LyftService.cancel_ride(headers['ride_id'], headers['cost_token'])
    require'pry';binding.pry
    lyft_service = LyftService.new(@user)
    ride_id = JSON.parse(request.body.string, symbolize_names: true)
    response = LyftService.confirm_cancel(ride_id, token)
    render json: response
    # render json: ''
  end
end
