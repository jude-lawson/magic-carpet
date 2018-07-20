class AdventuresController < ApplicationController
  

  def create
    prefs = params[:preferences]
    d_h = DestinationHandler.new(prefs)
    dest = d_h.find_a_restaurant
    # These methods require LyftService to take a user object
    # l_s = LyftService.new(@user)

    render json: {
      # These methods require LyftService to take a user object

      # price: l_s.get_estimate(@current_location, dest.location),
      destination: dest
    }
  end

end
