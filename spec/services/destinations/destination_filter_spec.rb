require 'rails_helper'
describe 'Filter' do
  describe '.remove' do
    it 'should remove all obejcts which dont fit with the specified parameters' do
      parameters ={
        search_settings: {
          'open_now' => true,
          'radius' => 3000,
          'latitude' => 39.7293,
          'longitude' => -104.9844,
          'price' => "1,2,3",
          'term' => 'restaurants'
        },
        restrictions: {
            categories: [
              "italian",
              "indian"],
            min_radius: 1000
          }
        }

      restaurants = File.open("./fixtures/restaurants.json")

      stub_request(:get, "https://api.yelp.com/v3/businesses/search?latitude=39.7293&longitude=-104.9844&open_now=true&price=1,2,3&radius=3000&term=restaurants").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'Authorization'=>"Bearer #{ENV['yelp_api_key']}",
       'User-Agent'=>'Faraday v0.12.2'
        }).
         to_return(status: 200, body: restaurants, headers: {})
      dh = DestinationHandler.new(parameters)
      rests = dh.get_restaurants
      results = Filter.remove(parameters[:restrictions], rests)
      results.each do |result|
        expect(result.distance).to be > parameters[:restrictions][:min_radius].to_i
        expect(result.categories).to_not include(parameters[:restrictions][:categories].first)
      end
    end
  end
end
