require 'rails_helper' 

RSpec.describe RoadTrip do 

let!(:fixture) {File.read('./spec/fixtures/direction_call.json')}
let!(:fixture1) {File.read('./spec/fixtures/weather_call.json')}

  it 'exists and has attributes' do 
    forecast_json = JSON.parse(fixture1, symbolize_names: true)
    route_json = JSON.parse(fixture, symbolize_names: true)
    directions = RoadTrip.new(route_json, forecast_json)

    expect(directions.travel_time).to eq("00:07:39")
    expect(directions.start_point).to eq('Arlington, VA')
    expect(directions.end_point).to eq('Arlington, VA')
    expect(directions.lat).to eq(38.84893)
    expect(directions.lon).to eq(-77.081223)
    expect(directions.weather_on_arrival).to eq('broken clouds')
    expect(directions.temp_on_arrival).to eq(62.83)
  end

end