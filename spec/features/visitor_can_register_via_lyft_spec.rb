# require 'rails_helper'
#
# describe 'Visitor' do
#   it 'can authenticate Lyft account' do
#     stub_omniauth
#
#     stub_request(:get, "https://api.lyft.com/v1/profile").
#          to_return(status: 200, body: {
#               "id": "123456789",
#               "first_name": "Rick",
#               "last_name": "Sanchez",
#               "has_taken_a_ride": true
#           }.to_json, headers: {})
#
#     visit lyft_login_path
#
#     expect(User.last.lyft_token).to eq('RWaoD3RdVSsHnY47Ep1oyXONNoYXbRl4bxG3tlctKcfZaE5ffmw6BuQg9+FNc1rdQib5Z7p/Go589u10nhJZ6aH86alTpqDfeeHK4NuCyNwQX/W9MFekzPI=')
#     expect(User.last.lyft_refresh_token).to eq('1ZOJuAwdH/Dq51Zp/ELPu2bOlC3KWELttUHaR+R2a56Lj1rCzQqBJRpNTI0xb27ks+lonCf4xalXiDLgl2dwHkRQ6mbOBORhV2L3WfJA5Z6L')
#     expect(User.last.first_name).to eq('Rick')
#     expect(User.last.last_name).to eq('Sanchez')
#     expect(User.last.lyft_id).to eq('123456789')
#   end
#
#   def stub_omniauth
#     OmniAuth.config.test_mode = true
#     OmniAuth.config.mock_auth[:lyft] = OmniAuth::AuthHash.new({
#       "token_type": "Bearer",
#       "access_token": "RWaoD3RdVSsHnY47Ep1oyXONNoYXbRl4bxG3tlctKcfZaE5ffmw6BuQg9+FNc1rdQib5Z7p/Go589u10nhJZ6aH86alTpqDfeeHK4NuCyNwQX/W9MFekzPI=",
#       "expires_in": 3600,
#       "refresh_token": "1ZOJuAwdH/Dq51Zp/ELPu2bOlC3KWELttUHaR+R2a56Lj1rCzQqBJRpNTI0xb27ks+lonCf4xalXiDLgl2dwHkRQ6mbOBORhV2L3WfJA5Z6L",
#       "scope": "profile offline rides.read public rides.request"
#     })
#   end
#
# end
