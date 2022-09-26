class BookSerializer 

  class << self 

    def book(forecast, books, location, quantity)
      {
        data: {
          id: nil,
          type: 'books',
          attributes:{
            destination: "#{location}",
            forecast:{
              summary: forecast[0].conditions,
              temperature: forecast[0].temperature
            },
            total_books_found: books[:numFound],
            books: books[:docs].shift(quantity).map do |book_data| 
              Book.new(book_data)
            end
          }
        }
      }
    end
  end
end