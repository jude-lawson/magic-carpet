class JsonWebToken

  def self.encode(payload)
    require'pry';binding.pry
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(payload)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base).first)
    rescue
      nil
  end

end