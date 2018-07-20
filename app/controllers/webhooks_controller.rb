class WebhooksController < ApplicationController

  def receive
    if valid_hook?
      response = JSON.parse(request.body.read)
      # insert where we want to send the response data - where will the react/rails endpoint be?
    end
  end

  private

  def valid_hook?
    # This method is not returning "true" as expected
    lyft_signature = JSON.parse(request.body.read)['headers']['X-Lyft-Signature'][7..-1]
    key = ENV['LYFT_WEBHOOK_TOKEN']
    data = response.body
    digest = OpenSSL::Digest.new('sha256')
    hmac = OpenSSL::HMAC.digest(digest, key, data)
    ActiveSupport::SecurityUtils.secure_compare(hmac, lyft_signature)
  end
end
