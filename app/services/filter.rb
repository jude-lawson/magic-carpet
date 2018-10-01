class Filter 
  def self.remove(parameters, restaurants)
    restaurants.reject do |restaurant|
      check_distance(parameters[:min_radius], restaurant) ||
      check_categories(parameters[:categories], restaurant)
    end
  end

  def self.check_distance(distance, restaurant)
    restaurant.distance.to_i <= distance.to_i
  end

  def self.check_categories(categories, restaurant)
    !(restaurant.categories & categories).empty?
  end
end
