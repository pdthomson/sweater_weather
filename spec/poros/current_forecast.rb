require 'rails_helper'

RSpec.describe CurrentForecast do 

let!(:fixture) {File.read('./spec/fixtures/weather_call.json')}

  it 'exists and has attributes' do 
    parsed_json = JSON.parse(fixture, symbolize_names: true)
    current_forecast = CurrentForecast.new(parsed_json[:current])

    expect(current_forecast).to be_a(CurrentForecast)
    expect(current_forecast.datetime).to eq("2022-09-26 00:33:03.000000000 -0400")
    expect(current_forecast.sunrise).to eq("2022-09-26 06:59:00.000000000 -0400")
    expect(current_forecast.sunset).to eq("2022-09-26 18:59:11.000000000 -0400")
    expect(current_forecast.temperature).to eq(63.48)
    expect(current_forecast.feels_like).to eq(63.48)
    expect(current_forecast.humidity).to eq(84)
    expect(current_forecast.uvi).to eq(0)
    expect(current_forecast.visibility).to eq(10000)
    expect(current_forecast.conditions).to eq("broken clouds")
    expect(current_forecast.icon).to eq("04n")
  end

end