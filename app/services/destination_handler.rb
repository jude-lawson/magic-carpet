class DestinationHandler
  def initialize(parameters)
    @parameters = parameters
    # should be:
    # {
        # search_settings: {
          # radius: int(in meters),
          # latitude: decimal,
          # longitude: decimal,
          # price: [int,int,int],
          # term: 'restaurants',
          # open_now: true
        # }
      # restrictions: {
      #   categories : [
      #     "italian",
      #     "indian"
      #   ]
      #   min_radius: 1000
      #   }
      # }
  end

  def find_a_restaurant
    WeightedRandomizer.new.decide(get_restaurants)
    # WeightedRandomizer is a module which will return a single object picked out of a given array
    # as long as that object responds to rating
  end

  def get_restaurants
    restaurants = YelpSearcher.new(parameters[:search_settings]).get_restaurants
    Filter.remove(parameters[:restrictions], restaurants)
    # This is the area which would act as a router between our different destination information retrival methods and locations
  end

  private

  attr_reader :parameters
end