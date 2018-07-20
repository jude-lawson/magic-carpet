require 'rails_helper'

describe WebhooksController, type: :controller do
  describe 'Lyft posts ride information to /lyft' do
    it 'returns json ride information' do
      json_file = "#{Rails.root}/spec/fixtures/lyft_webhooks/receive.json"
      data = File.read(json_file)
      post :receive, body: data
      json = JSON.parse(response.body)
      expect(json).to include('ride.status.updated')
      expect(json).to include('123456789')
      expect(json).to include('ride_id')
    end
  end
end
