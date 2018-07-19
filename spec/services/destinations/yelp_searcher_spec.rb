require 'rails_helper'

RSpec.describe YelpSearcher do
  describe 'get_restaurants' do
    it 'should return a list of Destination objects' do
      restaurants = File.open("./fixtures/restaurants.json")

      stub_request(:get, "https://api.yelp.com/v3/businesses/search?latitude=39.7293&longitude=-104.9844&open_now=true&price=1,2,3&radius=1000&term=restaurants").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer CJO1wLSD-ZirOvL0ViX92AA4zmZdAdgEy8Gs0C-1UzgfmSt7NJ_QYrEjAx6ZA6SOUnNYpQgXK3MiuaOa-gfFkRWo00l0ehR0E_9uEmuSHXOQhEL0wT9t3H8nCvZPW3Yx',
          'User-Agent'=>'Faraday v0.12.2'
           }).
         to_return(status: 200, body: restaurants, headers: {})

      parameters ={
        'open_now' => true,
        'radius' => 1000,
        'latitude' => 39.7293,
        'longitude' => -104.9844,
        'price' => "1,2,3",
        'term' => 'restaurants'
      }

      ys = YelpSearcher.new(parameters)
      restaurants = ys.get_restaurants

      expect(restaurants.first).to be_a(Destination)
      
    end
  end
end