class ApplicationController < ActionController::API
  before_action :set_jot, :authenticate!

  def from_http
    request.headers["Authorization"]["token"]
  end

  def set_jot
    require'pry';binding.pry
    @token ||= JsonWebToken.decode(from_http)
    rescue JWT::VerificationError, JWT::DecodeError
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def authenticate!
    require'pry';binding.pry
    if set_jot || @token[:id]
      @user ||= User.find_by(id: @token[:id])
      response.headers['Authorization'] = payload 
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def payload
    if @user
    {
      jwt: JsonWebToken.encode({id: @user.id})
    }
  end



end
