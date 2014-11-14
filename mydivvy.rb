# mydivvy.rb
require 'sinatra'
require 'net/http'
require 'json'

get '/' do 
  send_file 'public/index.html'
end

get '/getData' do
  stations = params[:stations] ? JSON.parse(params[:stations]) : []
  response = Net::HTTP.get(URI 'http://www.divvybikes.com/stations/json')
  response_json = JSON.parse(response)["stationBeanList"]

  # puts response_json
  response_json = response_json.reject {|k| !stations.include? k["id"] }
  erb response_json.to_json, :content_type => 'application/json'
end