Rails.application.config.middleware.use OmniAuth::Builder do
  provider :lyft, ENV['LYFT_CLIENT_ID'], ENV['LYFT_CLIENT_SECRET'], :scope => 'public,rides.read,rides.request, profile,offline'
end
