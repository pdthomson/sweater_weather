class MapFacade 

  class << self

    def coordinates(location)
      json = MapService.get_coordinates(location)
      parsed_json = json[:results][0][:locations][0]
      Location.new(parsed_json)
    end

    def roadtrip(from, to)
      trip = MapService.get_directions(from, to)
      RoadTrip.new(trip)
    end

  end
end