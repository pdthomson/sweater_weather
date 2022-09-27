class MapService 

  class << self

    def get_url(url, keyword, from = nil, to = nil)
      conn = Faraday.new(url:'http://www.mapquestapi.com' ) do |faraday|
        faraday.params[:key] = ENV['map_quest_api_key']
        faraday.params[:location] = keyword
        faraday.params[:from] = from
        faraday.params[:to] = to
      end
      
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_coordinates(keyword)
      get_url('/geocoding/v1/address', keyword)
    end

    def get_directions(from, to)
      get_url('/directions/v2/route', from, to)
    end

  end
end