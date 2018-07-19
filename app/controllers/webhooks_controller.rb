class WebhooksController < ApplicationController

  def receive
    ride_info = JSON.parse(request.body.read)
    user = User.find_by(lyft_id: ride_info['body']['event']['passenger']['user_id'])
    ride_id = ride_info['body']['event']['ride_id']
    ride_status = ride_info['body']['event']['status']
    user.rides.find(ride_id).update(status: ride_status)
  end

  private

  def valid_hook?
    lyft_signature = JSON.parse(request.body.read)['headers']['X-Lyft-Signature'][7..-1]
    key = ENV['LYFT_WEBHOOK_TOKEN']
    data = JSON.parse(request.body.read)['body'].to_json
    digest = OpenSSL::Digest.new('sha256')
    hmac = OpenSSL::HMAC.digest(digest, key, data)
    ActiveSupport::SecurityUtils.secure_compare(hmac, lyft_signature)
  end
end
