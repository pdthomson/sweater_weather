require 'rails_helper'

RSpec.describe CurrentForecast do 

let!(:fixture) {File.read('./spec/fixtures/weather_call.json')}

  it 'exists and has attributes' do 
    parsed_json = JSON.parse(fixture, symbolize_names: true)
    current_forecast = CurrentForecast.new(parsed_json[:current])

    expect(current_forecast).to be_a(CurrentForecast)
    expect(current_forecast.datetime).to eq("2022-09-25 17:04:23 -0400")
    expect(current_forecast.sunrise).to eq("2022-09-25 06:58:07 -0400")
    expect(current_forecast.sunset).to eq("2022-09-25 19:00:47 -0400")
    expect(current_forecast.temperature).to eq(296.74)
    expect(current_forecast.feels_like).to eq(296.75)
    expect(current_forecast.humidity).to eq(61)
    expect(current_forecast.uvi).to eq(0.64)
    expect(current_forecast.visibility).to eq(10000)
    expect(current_forecast.conditions).to eq("overcast clouds")
    expect(current_forecast.icon).to eq("04d")
  end

end