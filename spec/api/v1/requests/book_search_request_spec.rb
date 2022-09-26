require 'rails_helper'

RSpec.describe 'book/forecast for city search' do 

  it 'returns json', :vcr do 
    get '/api/v1/book-search?location=seattle,wa&quantity=5'

    expect(response).to be_successful
    expect(response).to have_http_status(200)
    book_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(book_response).to be_a Hash
    expect(book_response).to have_key(:data)
    expect(book_response[:data]).to have_key(:id)
    expect(book_response[:data]).to have_key(:type)
    expect(book_response[:data][:type]).to eq("books")
    expect(book_response[:data]).to have_key(:attributes)
    expect(book_response[:data][:attributes]).to have_key(:destination)
    expect(book_response[:data][:attributes]).to have_key(:forecast)
    expect(book_response[:data][:attributes][:forecast]).to have_key(:summary)
    expect(book_response[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(book_response[:data][:attributes]).to have_key(:total_books_found)
    expect(book_response[:data][:attributes]).to have_key(:books)
    book_response[:data][:attributes][:books].each do |book|
      expect(book).to have_key(:isbn)
      expect(book).to have_key(:title)
      expect(book).to have_key(:publisher)
    end
    expect(book_response[:data][:attributes]).to_not have_key(:key)
    expect(book_response[:data][:attributes]).to_not have_key(:type)
    expect(book_response[:data][:attributes]).to_not have_key(:seed)
    expect(book_response[:data][:attributes]).to_not have_key(:title_suggest)
    expect(book_response[:data][:attributes]).to_not have_key(:last_modified)
  end


end