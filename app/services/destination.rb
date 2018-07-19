class Destination
  attr_reader :latitude,
              :longitude,
              :name,
              :street_address,
              :city,
              :state,
              :zip_code

  def initialize(information)
    # require'pry';binding.pry
    @latitude = information[:coordinates][:latitude]
    @longitude = information[:coordinates][:longitude]
    @name = information[:name]
    @street_address = information[:location][:display_address][0]
    @city = information[:location][:city]
    @state = information[:location][:state]
    @zip_code = information[:location][:zip_code]
  end
end