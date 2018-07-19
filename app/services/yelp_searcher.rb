class YelpSearcher
  def initialize(parameters)
    @parameters = parameters
  end

  def get_restaurants
    JSON.parse(search.parameters.body, symbolize_names: true)
  end

  def search
    conn.get("/businesses/search") do |req|
      parameters.each do |search, value|
        req.params[search] = value
      end
    end
  end

  def conn
    Faraday.new(:url => "https://api.yelp.com/v3") do |faraday|
      faraday.headers["Authorization"] = ("Bearer " + ENV["lyft_api_key"])
      faraday.adapter Faraday.default_adapter
    end
  end

  private 
  attr_reader :parameters

end