require 'sinatra'

get '/' do
  return { 'message' => 'All is well!'}.to_json
end
