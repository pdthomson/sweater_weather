require 'rails_helper'

RSpec.describe MapFacade, :vcr do 

  it 'can return longitude and latitude from a poro with a facade call' do
    location = MapFacade.coordinates('seattle, WA')
    expect(location).to be_an_instance_of(Location)
  end
end

