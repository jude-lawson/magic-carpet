class YelpSearcher
  def self.get_restaurants(parameters)
    go_get('restaurants')
  end

  def self.go_get(path)
    %w(restaurant1 restaurant2)
  end
end