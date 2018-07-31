class AdventuresController < ApplicationController
  def create
    prefs = JSON.parse(request.body.string, symbolize_names: true)
    d_h = DestinationHandler.new(prefs)
    dest = d_h.find_a_restaurant
    puts("sending them to #{dest.name}")
    response = LyftService.get_estimate(headers['origin'], headers['destination'])
    # destination = { destination: dest }.to_json
    render json: response
    # , destination
  end
end
