class MapService 

  class << self

    def get_url(url, keyword)
      conn = Faraday.new(url:'http://www.mapquestapi.com/geocoding/v1/' ) do |faraday|
        faraday.params[:key] = ENV['map_quest_api_key']
        faraday.params[:location] = keyword
      end
      
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_coordinates(keyword)
      get_url('address', keyword)
    end
  end
end