class YelpSearcher
  def self.get_restaurants(parameters)
    go_get('restaurants')
  end

  def self.go_get(path)
    # this will connect to a conn method which will make the faraday call
    %w(restaurant1 restaurant2)
  end
end