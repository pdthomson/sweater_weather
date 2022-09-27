class RoadTripSerializer 

  class << self 

    def create_roadtrip(trip, forecast)
      {
        data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: trip.start_point,
          end_city: trip.end_point,
          travel_time: trip.travel_time,
          weather_at_eta: {
            temperature: forecast[0].temperature,
            conditions: forecast[0].conditions
          }
        }
      }
    }
    end

    def impossible_route(origin, destination)
      {
        data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: "#{origin}",
          end_city: "#{destination}",
          travel_time: 'impossible route',
          weather_at_eta: {
          }
        }
      }
    }
    end

  end
end