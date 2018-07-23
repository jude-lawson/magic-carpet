require 'rails_helper'

RSpec.describe AdventuresController, type: :controller do
  describe 'create' do
    it 'should return the price and destination in json' do
      restaurants = File.open("./fixtures/restaurants.json")

      stub_request(:get, "https://api.yelp.com/v3/businesses/search?latitude=39.7293&longitude=-104.9844&open_now=true&price=1,2,3&radius=1000&term=restaurants")
      .with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Bearer CJO1wLSD-ZirOvL0ViX92AA4zmZdAdgEy8Gs0C-1UzgfmSt7NJ_QYrEjAx6ZA6SOUnNYpQgXK3MiuaOa-gfFkRWo00l0ehR0E_9uEmuSHXOQhEL0wT9t3H8nCvZPW3Yx',
          'User-Agent'=>'Faraday v0.12.2'
           }).
         to_return(status: 200, body: restaurants, headers: {})

      user = create(:user)
      @request.headers["Authorization"] = {"token" => JsonWebToken.encode({id: user.id}) }
      parameters ={
        search_settings: {
          'open_now' => true,
          'radius' => 1000,
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
      post :create, params: { preferences: parameters }

      expect(response.body).to have_content("destination")
    end
  end
end
