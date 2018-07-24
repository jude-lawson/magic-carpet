class Api::V1::RidesController < ApplicationController
  def create
    Faraday.get('http://backend.turing.io')
  end
end