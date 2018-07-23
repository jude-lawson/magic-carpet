class Filter 
  def self.remove(parameters, restaurants)
    restaurants.reject do |restaurant|
      restaurant.distance.to_i <= parameters[:min_radius].to_i
      restaurant.categories.include?(parameters[:categories])
    end
  end
end
