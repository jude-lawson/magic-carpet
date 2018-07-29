class JsonWebToken

  def self.encode(payload)
    JWT.encode(payload, ENV['jwt_token'], 'none')
  end

  def self.decode(payload)
    decoded_string = JWT.decode(payload, ENV['jwt_token'], 'none').first
    decoded_json = JSON.parse(decoded_string)
    HashWithIndifferentAccess.new(decoded_json)
  end

end