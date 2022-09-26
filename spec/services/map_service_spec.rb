require 'rails_helper'

RSpec.describe 'Map Quest API' do 

  let!(:city_state) { 'waldorf, MD' }  
  let!(:fixture) { File.read('./spec/fixtures/map_call.json')}

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
end