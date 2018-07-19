class DestinationHandler
  def initialize(parameters)
    @parameters = parameters
    # should be:
    # {radius: int(in meters),
      # latitude: decimal,
      # longitude: decimal,
      # price: [int,int,int],
      # term: 'restaurants',
      # open_now: true
      # }
  end

  def find_a_restaurant
    WeightedRandomizer.new.decide(get_restaurants)
    # WeightedRandomizer is a module which will return a single object picked out of a given array
    # as long as that object responds to rating
  end

  def get_restaurants
    YelpSearcher.new(parameters).get_restaurants
    # This is the area which would act as a router between our different destination information retrival methods and locations
  end

  private

  attr_reader :parameters
end