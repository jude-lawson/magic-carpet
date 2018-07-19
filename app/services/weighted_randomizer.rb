class WeightedRandomizer

  def decide(destinations)
    # destinations should be an array of potential destinations, or other future objects which only need to respond
    # to #rating(and other future weightings)
    destinations.max_by {|dest| rand ** dest.rating }
  end
  
end