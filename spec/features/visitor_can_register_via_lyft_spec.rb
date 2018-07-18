require 'rails_helper'

describe 'Visitor' do
  it 'can authenticate Lyft account' do
    stub_omniauth

    visit lyft_login_path

    expect(User.last.first_name).to eq('Haley')
    expect(User.last.last_name).to eq('Mesander')
    expect(User.last.lyft_token).to eq('RWaoD3RdVSsHnY47Ep1oyXONNoYXbRl4bxG3tlctKcfZaE5ffmw6BuQg9+FNc1rdQib5Z7p/Go589u10nhJZ6aH86alTpqDfeeHK4NuCyNwQX/W9MFekzPI=')
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:lyft] = OmniAuth::AuthHash.new({
      "token_type": "Bearer",
      "access_token": "RWaoD3RdVSsHnY47Ep1oyXONNoYXbRl4bxG3tlctKcfZaE5ffmw6BuQg9+FNc1rdQib5Z7p/Go589u10nhJZ6aH86alTpqDfeeHK4NuCyNwQX/W9MFekzPI=",
      "expires_in": 3600,
      "refresh_token": "1ZOJuAwdH/Dq51Zp/ELPu2bOlC3KWELttUHaR+R2a56Lj1rCzQqBJRpNTI0xb27ks+lonCf4xalXiDLgl2dwHkRQ6mbOBORhV2L3WfJA5Z6L",
      "scope": "profile offline rides.read public rides.request"
    })
  end

end
