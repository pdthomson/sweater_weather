require 'rails_helper'

RSpec.describe 'Users API' do 

  it 'can create a user', :vcr do 
    user_params = {
      email: 'beannahdurke@hotmail.com',
      password: 'frogstomp',
      password_confirmation: 'frogstomp'
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    expect(response).to be_successful
    expect(response).to have_http_status(201)

    parsed_json = JSON.parse( response.body, symbolize_names: true)
    created_user = User.last 

    expect(created_user.email).to eq(user_params[:email])
    expect(created_user.email).to eq('beannahdurke@hotmail.com')
    expect(created_user.api_key.length).to eq(26)

    expect(parsed_json[:data]).to be_a(Hash)
    expect(parsed_json[:data][:attributes].keys).to include(:email, :api_key)
    expect(parsed_json[:data][:attributes]).to_not have_key(:password)
  end

  it 'does not work if passwords dont match', :vcr do 
    user_params = {
      email: 'beannahdurke@hotmail.com',
      password: 'frogstomp',
      password_confirmation: 'frog'
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(400)
    expect(error[:error]).to eq('Email is taken or left blank or passwords do not match')
  end

  it 'does not work if email is left blank', :vcr do 
    user_params = {
      email: '',
      password: 'frogstomp',
      password_confirmation: 'stomp'
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    error = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(400)
    expect(error[:error]).to eq("Email is taken or left blank or passwords do not match")
  end

end