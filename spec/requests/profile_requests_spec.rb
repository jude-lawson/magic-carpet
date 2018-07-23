require 'rails_helper'

RSpec.describe 'User Profile Requests' do
  describe '/api/v1/profile' do
    it 'should return a JSON payload of the user\'s data if the user has a valid JWT' do
      # Decode the JWT and check only against the user's primary id from the decoded information
      get '/api/v1/profile', {headers: {JWT_ID: ENV['jwt_token']}}

      expected_json_response = File.read('spec/fixtures/profile.json')

      expect(response).to be_successful
      expect(response.body).to eq(expected_json_response)
    end
  end
end