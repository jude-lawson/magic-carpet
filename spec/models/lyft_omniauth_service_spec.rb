require 'rails_helper'

describe 'Lyft Omniauth Service' do
  describe '#profile_info' do
    it 'returns a parsed JSON response with user profile information' do
      user = create(:user)

      stub_request(:get, "https://api.lyft.com/v1/profile").
           to_return(status: 200, body: {
                "id": "123456789",
                "first_name": "Rick",
                "last_name": "Sanchez",
                "has_taken_a_ride": true
            }.to_json, headers: {})

      lyft_service = LyftOmniauthService.new(user.lyft_token, user.lyft_refresh_token)
      actual = lyft_service.profile_info

      expect(actual).to be_a(Hash)
      expect(actual[:id]).to eq("123456789")
      expect(actual[:first_name]).to eq("Rick")
      expect(actual[:last_name]).to eq("Sanchez")
    end
  end

  describe '#renew_token' do
    it 'returns an active lyft token' do
      user = create(:user)

      stub_request(:post, 'https://api.lyft.com/oauth/token').
           to_return(status: 200, body: {
             access_token: 'jnuf9348fnci98w3rendoirfo3in4coi',
             token_type: 'bearer',
             expires_in: 3600,
             scope: 'profile offline rides.read public rides.request'
            }.to_json, headers: {})

      lyft_service = LyftOmniauthService.new(user.lyft_token, user.lyft_refresh_token)
      actual = lyft_service.renew_token

      expect(actual).to be_a(String)
      expect(actual).to eq('jnuf9348fnci98w3rendoirfo3in4coi')
    end
  end
end
