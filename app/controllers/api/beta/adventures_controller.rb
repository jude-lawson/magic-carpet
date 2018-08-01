class Api::Beta::AdventuresController < ApplicationController
  def create
    prefs = JSON.parse(request.body.string, symbolize_names: true)
    d_h = DestinationHandler.new(prefs)
    dest = d_h.find_a_restaurant
    puts("sending them to #{dest.name}")
    current_location = {
      latitude: prefs[:search_settings][:latitude],
      longitude: prefs[:search_settings][:longitude]
    }
    l_s = LyftService.new(@user)
    render json: {

      price_range: l_s.get_estimate(current_location, dest.location),
      destination: dest
    }
  end
end
