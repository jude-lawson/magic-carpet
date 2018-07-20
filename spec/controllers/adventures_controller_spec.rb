require 'rails_helper'

RSpec.describe AdventuresController, type: :controller do
  describe 'create' do
    it 'should return the price and destination in json' do
      user = create(:user)
      require'pry';binding.pry
      @request.headers["Authorization"] = {"token" => JsonWebToken.encode({id: user.id}) }
      post :create
    end
  end
end
