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
              summary: forecast[:current][:weather][0][:description],
              temperature: forecast[:current][:temp]
            },
            total_books_found: books[:numFound],
            books: books[:docs].shift(quantity).map do |book| 
              {
                isbn: book[:isbn],
                title: book[:title],
                publisher: book[:publisher]
              }
            end
          }
        }
      }
    end
  end
end