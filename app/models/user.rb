class User < ApplicationRecord
  belongs_to :setting

  def api_token=(token)
    @api_token = token
  end

  def api_token
    @api_token
  end

  def refresh_token=(refresh_token)
    @refresh_token = refresh_token
  end

  def refresh_token
    @refresh_token
  end

end
