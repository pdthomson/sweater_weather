require 'rails_helper'

RSpec.describe 'Road trip API call' do 
  before(:each) do 
    User.create!(email: 'pachzrince@md.com', password: 'smib', password_confirmation: 'smib', api_key:'hrj56wtlizdtiiigzjwdbcsmwmwuxk0b')
    @trip_params = {
      origin: 'laplata, maryland',
      destination: 'denver, colorado',
      api_key: 'hrj56wtlizdtiiigzjwdbcsmwmwuxk0b'
    }
    
    @headers = {"CONTENT_TYPE" => 'application/json'}
  end

  it 'makes a post request to the api end point', :vcr do 
    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(@trip_params)

    expect(response).to be_successful 
    expect(response).to have_http_status(200)
  end

  it 'returns a formatted road tripp json response', :vcr do 
    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(@trip_params)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    trip = parsed_json[:data]

    expect(trip).to be_a(Hash)
    expect(trip.keys).to include(:id, :type, :attributes)
    expect(trip[:id]).to eq(nil)
    expect(trip[:type]).to eq('roadtrip')
    expect(trip[:attributes]).to be_a(Hash)

    expect(trip[:attributes].keys).to include(:start_city, :end_city, :travel_time, :weather_at_eta)
    expect(trip[:attributes][:start_city]).to be_a(String)
    expect(trip[:attributes][:end_city]).to be_a(String)
    expect(trip[:attributes][:travel_time]).to be_a(String)

    expect(trip[:attributes][:weather_at_eta]).to be_a(Hash)
    expect(trip[:attributes][:weather_at_eta].keys).to include(:temperature, :conditions)
    expect(trip[:attributes][:weather_at_eta][:temperature]).to be_a(Numeric)
    expect(trip[:attributes][:weather_at_eta][:conditions]).to be_a(String)
  end

  it 'returns an error if origin parameter is missing', :vcr do
    missing_params = 
    {
      origin: '',
      destination: 'seattle, wa',
      api_key: 'hrj56wtlizdtiiigzjwdbcsmwmwuxk0b'
    }

    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(missing_params)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_json[:message]).to eq('param is missing or the value is empty: origin')
  end

  it 'returns an error if the destination parameter is missing', :vcr do 
    missing_params = 
    {
      origin: 'seattle, wa',
      destination: '',
      api_key: 'hrj56wtlizdtiiigzjwdbcsmwmwuxk0b'
    }

    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(missing_params)

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_json[:message]).to eq('param is missing or the value is empty: destination')
  end

  it 'returns an error if the api key is missing', :vcr do 
    missing_params = 
    {
      origin: 'seattle, wa',
      destination: 'denver, co',
      api_key: ''
    }

    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(missing_params)

    expect(response).to_not be_successful
    expect(response).to have_http_status(401)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_json[:message]).to eq('Api key blank or not matching')
  end

  it 'returns impossible route error if given an impossible route', :vcr do 
    impossible_params = 
    {
      origin: 'seattle, wa',
      destination: 'tokyo, japan',
      api_key: 'hrj56wtlizdtiiigzjwdbcsmwmwuxk0b'
    }

    post '/api/v1/road_trip', headers: @headers, params: JSON.generate(impossible_params)
    
    parsed_json = JSON.parse(response.body, symbolize_names: true)
    trip = parsed_json[:data]

    expect(response).to be_successful
    expect(response).to have_http_status(200)

    expect(trip).to be_a(Hash)
    expect(trip.keys).to include(:id, :type, :attributes)
    expect(trip[:id]).to eq(nil)
    expect(trip[:type]).to eq('roadtrip')
    expect(trip[:attributes]).to be_a(Hash)

    expect(trip[:attributes].keys).to include(:start_city, :end_city, :travel_time, :weather_at_eta)
    expect(trip[:attributes][:start_city]).to be_a(String)
    expect(trip[:attributes][:start_city]).to eq('seattle, wa')
    expect(trip[:attributes][:end_city]).to be_a(String)
    expect(trip[:attributes][:end_city]).to eq('tokyo, japan')

    expect(trip[:attributes][:travel_time]).to eq('impossible')
    expect(trip[:attributes][:weather_at_eta]).to be_a(Hash)
    expect(trip[:attributes][:weather_at_eta].keys).to_not include(:temperature, :conditions)
  end

end