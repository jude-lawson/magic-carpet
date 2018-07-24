class Api::V1::TestController < ApplicationController
  def create
    Faraday.get('http://backend.turing.io')
  end

  def index
    Faraday.get('http://backend.turing.io')
  end
end