require 'rails_helper'

RSpec.describe DailyForecast do 

let!(:fixture) {File.read('./spec/fixtures/weather_call.json')}

  it 'exists and has attribute' do 
    parsed_json = JSON.parse(fixture, symbolize_names: true)
    daily_forecast = DailyForecast.new(parsed_json[:daily][0])
    
    expect(daily_forecast).to be_an_instance_of(DailyForecast)
    expect(daily_forecast.date).to eq('2022-09-26 12:00:00.000000000 -0400')
    expect(daily_forecast.sunrise).to eq('2022-09-26 06:59:00.000000000 -0400')
    expect(daily_forecast.sunset).to eq('2022-09-26 18:59:11.000000000 -0400')
    expect(daily_forecast.max_temp).to eq(79.03)
    expect(daily_forecast.min_temp).to eq(54.45)
    expect(daily_forecast.conditions).to eq("clear sky")
    expect(daily_forecast.icon).to eq('01d')
  end


end