class JsonWebToken

  def self.encode(payload)
    # JWT.encode(payload, ENV['jwt_token'], 'HS384', { typ: "JWT"})
    payload
  end

  def self.decode(payload)
    # decoded_string = JWT.decode(payload, ENV['jwt_token'], 'HS384', { typ: "JWT"}).first
    # decoded_json = JSON.parse(decoded_string)
    # HashWithIndifferentAccess.new(decoded_json)
    HashWithIndifferentAccess.new(payload)

  end

end