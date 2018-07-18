require 'rails_helper'

describe 'Lyft Service' do
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

      lyft_service = LyftService.new(user.lyft_token, user.lyft_refresh_token)
      actual = lyft_service.profile_info

      expect(actual).to be_a(Hash)
      expect(actual[:id]).to eq("123456789")
      expect(actual[:first_name]).to eq("Rick")
      expect(actual[:last_name]).to eq("Sanchez")
    end
  end
end
