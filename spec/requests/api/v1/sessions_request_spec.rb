require 'rails_helper'

RSpec.describe 'User session' do 

  it 'sends a post request for a user session', :vcr do 
    user = User.create!(email: 'geslywarcia@ff14.com', password: 'timetravel', password_confirmation: 'timetravel')

    user_params = {
      email:'geslywarcia@ff14.com',
      password: 'timetravel'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)

    user = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(response).to have_http_status(200)
    expect(user).to have_key(:data)
    expect(user[:data].keys).to include(:type, :id, :attributes)
    expect(user[:data][:attributes].keys).to include(:email, :api_key)
    expect(user[:data][:attributes]).to_not have_key(:password)
  end

end