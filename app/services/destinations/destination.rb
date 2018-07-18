class Destination < ApplicationRecord
  def initialize(information)
    @location = information[:location]
    @name = information[:name]
    @street_address = information[:street_address]
    @city = information[:city]
    @state = information[:state]
    @zip_code = information[:zip_code]
  end
end