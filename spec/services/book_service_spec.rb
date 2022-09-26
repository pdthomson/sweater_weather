require 'rails_helper'

RSpec.describe 'Book API' do 

  it 'returns a response from faraday',  :vcr do 
    json_response = BookService.conn
    expect(json_response).to be_a(Faraday::Connection)
  end

  it 'returns forecast details based on latitude and longitude', :vcr do
    city_state = 'seattle, wa'

    books = BookService.get_books(city_state)
    expect(books).to be_a(Hash)
    expect(books.keys).to include(:numFound, :docs)
    expect(books[:docs][0].keys).to include(:isbn, :title, :publisher)
  end
end