require 'rails_helper'

RSpec.describe BookFacade do 

  it 'returns books based on lat/lon', :vcr do 
    city_state = 'seattle, wa'

    books = BookService.get_books(city_state)
    expect(books).to be_a(Hash)
    expect(books.keys).to include(:numFound, :docs)
    expect(books[:docs][0].keys).to include(:isbn, :title, :publisher)
  end

end