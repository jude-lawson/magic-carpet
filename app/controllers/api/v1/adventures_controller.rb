class Api::V1::AdventuresController < ApplicationController
  def create
    dest = DestinationHandler.new(preferences).find_a_restaurant
    puts("sending them to #{dest.name}")
    current_location = {
      latitude: preferences[:search_settings][:latitude],
      longitude: preferences[:search_settings][:longitude]
    }
    l_s = LyftService.new(@user)
    render json: {

      price_range: l_s.get_estimate(current_location, dest.location),
      destination: dest
    }
  end
end