class DestinationHandler
  def initialize(parameters)
    @parameters = parameters
    # parameters is hash containing the information about the user location, price range, radius, ratings, and restrictions(which should be stored as an array of tags)
  end

  def find_a_restaurant
    WeightedRandomizer.new.decide(get_restaurants)
    # WeightedRandomizer is a module which will return a single object picked out of a given array
    # as long as that object responds to rating
  end

  def get_restaurants
    YelpSearcher.get_restaurants(parameters)
    # This is the area which would act as a router between our different destination information retrival methods and locations
  end

  private

  attr_reader :parameters
end