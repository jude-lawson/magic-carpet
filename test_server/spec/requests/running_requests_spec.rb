ENV['RACK_ENV'] = 'test'

require '../../test_server'
require 'rspec'
require 'rack/test'

RSpec.describe 'Server is running' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should be running' do
    get '/'

    expected_response = {
      'message' => 'All is well!'
    }

    expect(last_response).to be_ok
    expect(last_response.body).to eq(expected_response)
  end
end
