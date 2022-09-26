require 'rails_helper'

RSpec.describe Book do 

  it 'exists and has attributes' do 
    book_data = {
      title: 'Seattle, Wa',
      publisher: ['Langenscheidt Publishers'],
      isbn: ['9780738520643", "0738520640']
    }

    book = Book.new(book_data)

    expect(book).to be_a(Book)
    expect(book.title).to eq('Seattle, Wa')
    expect(book.publisher).to eq(['Langenscheidt Publishers'])
    expect(book.isbn).to eq(['9780738520643", "0738520640'])
  end

end