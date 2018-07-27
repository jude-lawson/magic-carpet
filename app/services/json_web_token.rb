class JsonWebToken

  def self.encode(payload)
    JWT.encode(payload, ENV['jwt_token'], 'HS256')
  end

  def self.decode(payload)
    return HashWithIndifferentAccess.new(JWT.decode(payload, ENV['jwt_token'],'HS256').first)
    rescue
      nil
  end

end