class AdventuresController < ApplicationController
  def create
    prefs = JSON.parse(request.body.string, symbolize_names: true)
    d_h = DestinationHandler.new(prefs)
    dest = d_h.find_a_restaurant
    puts("sending them to #{dest.name}")
<<<<<<< HEAD
    response = LyftService.get_estimate(headers['origin'], headers['destination'])
    # destination = { destination: dest }.to_json
    render json: response
    # , destination
=======
    current_location = {
      latitude: prefs[:search_settings][:latitude], 
      longitude: prefs[:search_settings][:longitude] 
    }
    l_s = LyftService.new(@user)
    render json: {

      price_range: l_s.get_estimate(current_location, dest.location),
      destination: dest
    }
>>>>>>> e7c4c7236749082518db1b34370be578c34fcd77
  end
end
