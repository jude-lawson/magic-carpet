class AdventuresController < ApplicationController

  def create
    prefs = params[:preferennces]
    d_h = DestinationHandler.new(prefs)
    dest = d_h.find_a_restaurant
    l_s = LyftService.new(@user)
    render json: {price: l_s.get_estimate(@current_location, dest.location), destination: dest}
  end

end
