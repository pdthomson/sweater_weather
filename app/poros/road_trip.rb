class RoadTrip

  attr_reader :travel_time,
              :start_point,
              :end_point,
              :lat,
              :lon

  def initialize(data)
    @travel_time = data[:route][:formattedTime]
    @start_point = "#{data[:route][:locations][0][:adminArea5]}, #{data[:route][:locations][0][:adminArea3]}"
    @end_point = "#{data[:route][:locations][1][:adminArea5]}, #{data[:route][:locations][1][:adminArea3]}"
    @lat = data[:route][:locations][1][:displayLatLng][:lat]
    @lon = data[:route][:locations][1][:displayLatLng][:lng]
  end

end