require 'rails_helper'

RSpec.describe Destination::DestinationHandler do
  describe 'get_restaurants' do
    it 'should be fully wired together' do
      parameters = {
        radius: 5,
        latitude: 15.4095,
        longitude: 14.3454,
        max_price: 3,
        restrictions: [
          "hot dogs",
          "hamburgers"
        ]
      }
      dh = DestinationHandler.new(parameters)
      restaurant = dh.find_a_restaurant
      expect(restaurant).to be true
    end
  end
end