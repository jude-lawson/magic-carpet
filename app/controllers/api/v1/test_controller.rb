class Api::V1::TestController < ApplicationController
  skip_before_action :authenticate!
  
  def create
    Faraday.get('http://backend.turing.io')
  end

  def index
    Faraday.get('http://backend.turing.io')
  end
end