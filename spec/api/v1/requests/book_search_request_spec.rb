require 'rails_helper'

RSpec.describe 'book/forecast for city search' do 

  it 'returns a successful response', :vcr do 
    get '/api/v1/book-search?location=seattle,wa&quantity=5'

    expect(response).to be_successful
    expect(response).to have_http_status(200)
  end




end