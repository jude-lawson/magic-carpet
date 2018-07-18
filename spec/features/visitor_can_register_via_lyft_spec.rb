require 'rails_helper'

describe 'Visitor' do
  it 'can authenticate Lyft account' do
    stub_omniauth

    expect(User.last.first_name).to eq('Haley')
    expect(User.last.last_name).to eq('Mesander')
    expect(User.last.lyft_token).to eq('75FAoU6oY/3fXNJvLUJmeycuN4vP5zAxtID+mblr2iGY4TNfs5Z7FjY1XWUf0KSiW6IYf11ZNhNQNLruF5CUZzOl9u9+3+5TZLjDJkHSngGYwV93dfzPahw=')
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:lyft] = OmniAuth::AuthHash.new({
      "token_type": "Bearer",
      "access_token": "75FAoU6oY/3fXNJvLUJmeycuN4vP5zAxtID+mblr2iGY4TNfs5Z7FjY1XWUf0KSiW6IYf11ZNhNQNLruF5CUZzOl9u9+3+5TZLjDJkHSngGYwV93dfzPahw=",
      "expires_in": 3600,
      "refresh_token": "lLleZdybO0vhXwMBhiNM8cBxmPYF5sVPGPgDvVdpZkILlTDiI0Pg+SSoenLDnfCjHbN7x4RpFs9DkC1mmM30zyoUjzTAMbJ//mhCgRqZXw0O",
      "scope": "profile offline rides.read public rides.request"
    })
  end

end
