require 'rails_helper'

RSpec.describe 'Weather API' do
let!(:lat) { '38.61517254380903'}
let!(:lon) { '-76.94859636101383'}
let!(:fixture) {File.read('./spec/fixtures/weather_call.json')}

  describe 'weather forecast details' do 
    it 'returns current weather details based on latitude and longitude ', :vcr do
      allow(ForecastService).to receive(:get_forecast).and_return(JSON.parse(fixture, symbolize_names: true))
      current_forecast = ForecastService.get_forecast(lat, lon)[:current]

      expect(current_forecast).to be_a(Hash)
      expect(current_forecast.keys).to include(:dt,
      :sunrise,
      :sunrise,
      :sunset,
      :temp,
      :feels_like,
      :pressure,
      :humidity,
      :dew_point,
      :uvi,
      :clouds,
      :visibility,
      :wind_speed,
      :wind_deg,
      :wind_gust,
      :weather)
      expect(current_forecast.keys).to_not include(:minutely)
      expect(current_forecast[:weather][0].keys).to include(:id, :main, :description, :icon)
    end

    it 'returns hourly weather data based on latitude and longitude', :vcr do 
      allow(ForecastService).to receive(:get_forecast).and_return(JSON.parse(fixture, symbolize_names: true))
      hourly_forecast = ForecastService.get_forecast(lat, lon)[:hourly][0]
      
      expect(hourly_forecast).to be_a(Hash)
      expect(hourly_forecast.keys).to include(:dt,
      :temp,
      :feels_like,
      :pressure,
      :humidity,
      :dew_point,
      :uvi,
      :clouds,
      :visibility,
      :wind_speed,
      :wind_deg,
      :wind_gust,
      :weather)
      expect(hourly_forecast.keys).to_not include(:minutely, 
      :sunrise,
      :sunrise,
      :sunset,)
      expect(hourly_forecast[:weather][0].keys).to include(:id, :main, :description, :icon)
    end

    it 'returns daily weather data based on latitude and longitude', :vcr do 
      allow(ForecastService).to receive(:get_forecast).and_return(JSON.parse(fixture, symbolize_names: true))
      daily_forecast = ForecastService.get_forecast(lat, lon)[:daily][0]
      
      expect(daily_forecast).to be_a(Hash)
      expect(daily_forecast.keys).to include(:dt,
      :sunrise,
      :sunset,
      :moonrise,
      :moonset,
      :moon_phase)
      expect(daily_forecast[:temp].keys).to include(:day, :min, :max, :night, :eve, :morn)
      expect(daily_forecast[:feels_like].keys).to include(:day, :night, :eve, :morn)
      expect(daily_forecast.keys).to_not include(:minutely)     
    end
  end
end