class MapFacade 

  class << self

    def coordinates(location)
      json = MapService.get_coordinates(location)
      parsed_json = json[:results][0][:locations][0]
      Location.new(parsed_json)
    end

    def roadtrip(from, to)
      trip = MapService.get_directions(from, to)
      if trip[:route][:routeError][:errorCode] == 2 
        'impossible route'
      else
        lat = trip[:route][:locations][1][:displayLatLng][:lat]
        lon = trip[:route][:locations][1][:displayLatLng][:lng]
        weather = ForecastService.get_forecast(lat, lon)
        RoadTrip.new(trip, weather)
      end
    end

  end
end