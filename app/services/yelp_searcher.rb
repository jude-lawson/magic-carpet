class YelpSearcher
  def self.get_restaurants(parameters)
    go_get('restaurants')
  end

  def self.go_get(path)
    # this will connect to a conn method which will make the faraday call
    %w(restaurant1 restaurant2)
  end

  def go_get(info)
    JSON.parse(conn.get("").body)
  end

  def conn
    Faraday.new(:url => "https://api.yelp.com/v3") do |faraday|
      faraday.headers["Authorization"] = ("Bearer " + token)
      faraday.adapter Faraday.default_adapter
    end
  end
end