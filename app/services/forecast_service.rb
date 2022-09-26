class ForecastService 

  class<< self

    def get_url(url, lat, lon)
      conn = Faraday.new('https://api.openweathermap.org/data/2.5/') do |faraday|
        faraday.params[:appid] = ENV['open_weather_api_key']
        faraday.params[:lat] = lat
        faraday.params[:lon] = lon
        faraday.params[:exclude] = 'minutely,alerts'
      end
      
      response = conn.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_forecast(lat, lon)
      get_url('onecall', lat, lon)
    end
    
  end
end