class ForecastFacade

  class << self 

    def forecast(lat, lon)
      json = ForecastService.get_forecast(lat, lon)
      current = CurrentForecast.new(json[:current])
      daily = json[:daily][0..4].map{ |data| DailyForecast.new(data) }
      hourly = json[:hourly][0..7].map { |data| HourlyForecast.new(data)}
      # binding.pry
    end

  end

end