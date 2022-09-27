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



end