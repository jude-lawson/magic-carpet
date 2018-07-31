class Api::V1::RidesController < ApplicationController
  def create
    mock_info = File.read('fixtures/lyft_call_response.json')
    render json: mock_info
  end

  def edit
    mock_info = File.read('fixtures/lyft_cancel_response_failure.json')
    render json: mock_info
  end
end
