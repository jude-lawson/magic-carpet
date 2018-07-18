class AdventuresController < ApplicationController
  def create
    render json: { message: 'It works!' }
  end
end
