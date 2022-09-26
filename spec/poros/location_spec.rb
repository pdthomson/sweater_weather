require 'rails_helper'

RSpec.describe Location do 
  let!(:fixture) { File.read('./spec/fixtures/map_call.json')}

  it 'exists and has attributes' do 
    data = JSON.parse(fixture, symbolize_names: true)[:results][0][:locations][0]
    location = Location.new(data)

    expect(location).to be_an_instance_of(Location)
    expect(location.lat).to eq(38.637545)
    expect(location.lon).to eq(-76.895271)
  end


end