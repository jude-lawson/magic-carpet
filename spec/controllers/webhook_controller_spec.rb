require 'rails_helper'

describe WebhooksController, type: :controller do
  describe "Lyft posts ride information to /lyft" do
    it "creates a new LyftWebhook submission" do
      json_file = "#{Rails.root}/spec/fixtures/lyft_webhooks/receive.json"
      data = File.read(json_file)
      post :receive, body: data
      expect(Webhooks::Received).to receive(:save).with(data: data, ride: '123456').and_return(true)
    end
  end
end
