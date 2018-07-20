class Destination
  attr_reader :name,
              :rating,
              :categories,    
              :latitude,
              :longitude,
              :street_address,
              :city,
              :state,
              :zip_code

  def initialize(information)
    @name = information[:name]
    @price = information[:price]
    @rating = information[:rating]
    @categories = information[:categories]
    @latitude = information[:coordinates][:latitude]
    @longitude = information[:coordinates][:longitude]
    @street_address = information[:location][:display_address][0]
    @city = information[:location][:city]
    @state = information[:location][:state]
    @zip_code = information[:location][:zip_code]
  end

  def location
    {
      latitude: latitude,
      longitude: longitude
    }
  end
end