require 'rails_helper'

RSpec.describe 'Adventure Requests' do
  context 'POST /api/v1/adventures' do
    xit 'should be successful' do
      post '/api/v1/adventures'

      expect(response).to be_successful
    end
  end
end
