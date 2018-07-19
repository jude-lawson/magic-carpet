require 'rails_helper'

RSpec.describe DestinationHandler do
  describe 'get_restaurants' do
    it 'should returns a list of Destination objects' do
      parameters = {
        radius: 2000,
        latitude: 39.73915,
        longitude: -104.9847,
        price: [1,2,3],
        term: 'restaurants',
        open_now: true
      }

      restaurants = File.open("./fixtures/restaurants.json")

      stub_request(:get, "https://api.yelp.com/v3/businesses/search?latitude=39.73915&longitude=-104.9847&open_now=true&price%5B%5D=1&price%5B%5D=2&price%5B%5D=3&radius=2000&term=restaurants")
      .with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer CJO1wLSD-ZirOvL0ViX92AA4zmZdAdgEy8Gs0C-1UzgfmSt7NJ_QYrEjAx6ZA6SOUnNYpQgXK3MiuaOa-gfFkRWo00l0ehR0E_9uEmuSHXOQhEL0wT9t3H8nCvZPW3Yx',
          'User-Agent'=>'Faraday v0.12.2'
           }).
         to_return(status: 200, body: restaurants, headers: {})

      dh = DestinationHandler.new(parameters)
      rests = dh.get_restaurants
      rests.each do |restaurant|
        expect(restaurant).to be_a(Destination)
      end
    end
    describe 'find a restaurant' do
      it 'should return a single Destination from a list of destinations' do
        parameters = {
          radius: 2000,
          latitude: 39.73915,
          longitude: -104.9847,
          price: [1,2,3],
          term: 'restaurants',
          open_now: true
        }
  
        restaurants = File.open("./fixtures/restaurants.json")
  
        stub_request(:get, "https://api.yelp.com/v3/businesses/search?latitude=39.73915&longitude=-104.9847&open_now=true&price%5B%5D=1&price%5B%5D=2&price%5B%5D=3&radius=2000&term=restaurants")
        .with(
             headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'Bearer CJO1wLSD-ZirOvL0ViX92AA4zmZdAdgEy8Gs0C-1UzgfmSt7NJ_QYrEjAx6ZA6SOUnNYpQgXK3MiuaOa-gfFkRWo00l0ehR0E_9uEmuSHXOQhEL0wT9t3H8nCvZPW3Yx',
            'User-Agent'=>'Faraday v0.12.2'
             }).
           to_return(status: 200, body: restaurants, headers: {})

        dh = DestinationHandler.new(parameters)
        rests = dh.get_restaurants
        result = dh.find_a_restaurant
        expect(result).to be_a(Destination)
      end
    end
  end
end