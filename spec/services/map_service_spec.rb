require 'rails_helper'

RSpec.describe 'Map Quest API' do 

  let!(:city_state) { 'waldorf, MD' }  
  let!(:fixture) { File.read('./spec/fixtures/map_call.json')}
  let!(:fixture2) {File.read('./spec/fixtures/direction_call.json')}

  it 'returns location information based on city/state keyword search', :vcr do 
    allow(MapService).to receive(:get_coordinates).and_return(JSON.parse(fixture, symbolize_names: true))

    location_information = MapService.get_coordinates(city_state)
    lat_long = location_information[:results][0][:locations][0]
    
    expect(location_information).to be_a(Hash)
    expect(location_information).to have_key(:results)
    expect(location_information[:results][0]).to have_key(:locations)
    expect(lat_long).to have_key(:latLng)
    expect(lat_long[:latLng].keys).to include(:lat, :lng)
  end

  it 'returns direction information from mapquest api call' do 
    allow(MapService).to receive(:get_directions).and_return(JSON.parse(fixture2, symbolize_names: true))

    directions = MapService.get_directions('Clarendon Blvd,Arlington,VA', '2400+S+Glebe+Rd,+Arlington,+VA')

    expect(directions).to be_a(Hash)
    expect(directions.keys).to include(:route)
    expect(directions[:route][:formattedTime]).to be_a(String)
    expect(directions[:route][:locations][0][:adminArea5]).to eq('Arlington')
    expect(directions[:route][:locations][0][:adminArea3]).to eq('VA')
    expect(directions[:route][:locations][1][:adminArea5]).to eq('Arlington')
    expect(directions[:route][:locations][1][:adminArea3]).to eq('VA')
  end
end