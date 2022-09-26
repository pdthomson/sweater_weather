class ForecastSerializer

  class << self 

    def forecast(weather)
      # binding.pry
      {
        data: {
          id: nil,
          type: 'forecast',
          attributes: {
            current_weather:
            {
              datetime: weather[0].datetime,
              sunrise: weather[0].sunrise,
              sunset: weather[0].sunset,
              temperature: weather[0].temperature,
              feels_like: weather[0].feels_like,
              humidity: weather[0].humidity,
              uvi: weather[0].uvi,
              visibility: weather[0].visibility,
              conditions: weather[0].conditions,
              icon: weather[0].icon
            },
            daily_weather: weather[1].map do |daily|
            {
              date: daily.date,
              sunrise: daily.sunrise,
              sunset: daily.sunset,
              max_temp: daily.max_temp,
              min_temp: daily.min_temp,
              conditions: daily.conditions,
              icon: daily.icon
            }
            end,
            hourly_weather: weather[2].map do |hourly|
              {
                time: hourly.time,
                temperature: hourly.temperature,
                conditions: hourly.conditions,
                icon: hourly.icon
              }
            end
          }
        }
      }
    end
  end
end