require 'rails_helper'

RSpec.describe HourlyForecast do 

let!(:fixture) {File.read('./spec/fixtures/weather_call.json')}

  it 'exists and has attributes' do 
    parsed_json = JSON.parse(fixture, symbolize_names: true)
    hourly_forecast = HourlyForecast.new(parsed_json[:hourly][0])

    expect(hourly_forecast).to be_an_instance_of(HourlyForecast)
    expect(hourly_forecast.time).to eq('2022-09-26 00:00:00.000000000 -0400')
    expect(hourly_forecast.conditions).to eq('broken clouds')
    expect(hourly_forecast.icon).to eq('04n')
  end
end