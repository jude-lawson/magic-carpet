class AdventuresController < ApplicationController
  def create
    prefs = JSON.parse(request.body.string, symbolize_names: true)
    d_h = DestinationHandler.new(prefs)
    dest = d_h.find_a_restaurant
    puts("sending them to #{dest}")
    # These methods require LyftService to take a user object
    # l_s = LyftService.new(@user)

    render json: {
      # These methods require LyftService to take a user object

      # price: l_s.get_estimate(@current_location, dest.location),
      destination: dest
    }
  end
end
