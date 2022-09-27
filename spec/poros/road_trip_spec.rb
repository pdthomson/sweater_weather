require 'rails_helper' 

RSpec.describe RoadTrip do 

let!(:fixture) {File.read('./spec/fixtures/direction_call.json')}

  it 'exists and has attributes' do 
    parsed_json = JSON.parse(fixture, symbolize_names: true)
    directions = RoadTrip.new(parsed_json)

    expect(directions.travel_time).to eq("00:07:39")
    expect(directions.start_point).to eq('Arlington, VA')
    expect(directions.end_point).to eq('Arlington, VA')
    expect(directions.lat).to eq(38.84893)
    expect(directions.lon).to eq(-77.081223)
  end

end