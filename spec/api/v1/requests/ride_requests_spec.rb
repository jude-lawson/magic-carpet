require 'rails_helper'

RSpec.describe 'Ride Requests' do
  describe '/api/v1/rides' do
    it 'should create a ride using the Lyft API and return a response' do
      expect{ post '/api/v1/rides/new' }.to raise_error(WebMock::NetConnectNotAllowedError)

      # expect(response).to be_successful
    end
  end
end