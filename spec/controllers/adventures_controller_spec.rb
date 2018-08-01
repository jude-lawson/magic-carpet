require 'rails_helper'

RSpec.describe Api::V1::AdventuresController, type: :controller do
  before :each do
    restaurants = File.open("./fixtures/restaurants.json")
    stub_request(:get, "https://api.yelp.com/v3/businesses/search?latitude=39.7293&longitude=-104.9844&open_now=true&price=1,2,3&radius=3000&term=restaurants").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Authorization'=>'Bearer CJO1wLSD-ZirOvL0ViX92AA4zmZdAdgEy8Gs0C-1UzgfmSt7NJ_QYrEjAx6ZA6SOUnNYpQgXK3MiuaOa-gfFkRWo00l0ehR0E_9uEmuSHXOQhEL0wT9t3H8nCvZPW3Yx',
        'User-Agent'=>'Faraday v0.12.2'
        }).
        to_return(status: 200, body: restaurants, headers: {})

    stub_request(:get, "https://api.lyft.com/v1/cost?end_lat=39.73981&end_lng=-104.96383&ride_type=lyft&start_lat=39.7293&start_lng=-104.9844").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v0.12.2'
           }).
           to_return(status: 200, body: '', headers: {})
  end

  describe 'create' do
    xit 'should return the price and destination in json' do


         Setting.create(
           id: 0,
           max_radius: 4000,
           min_radius: 1000,
           min_rating: 0,
         )

      user = User.create!
      @request.headers["payload"] = JsonWebToken.encode({"id" => user.id}.to_json)
      parameters = {
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
      post :create, body: parameters.to_json

      expect(response.body).to have_content("destination")
    end
  end
end
