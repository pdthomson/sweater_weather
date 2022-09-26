class BookService 

  class << self 

    def conn
      url = "http://openlibrary.org/search.json"
      Faraday.new(url: url)     
    end

    def get_books(location)
      response = conn.get do |faraday|
        faraday.params[:q] = location
      end 
      JSON.parse(response.body, symbolize_names: true)
    end

  end
end