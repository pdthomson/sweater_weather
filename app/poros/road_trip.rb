class RoadTrip

  attr_reader :travel_time,
              :start_point,
              :end_point,
              :lat,
              :lon,
              :time,
              :weather_on_arrival,
              :temp_on_arrival

  def initialize(data, forecast)
    @travel_time = data[:route][:formattedTime]
    @start_point = "#{data[:route][:locations][0][:adminArea5]}, #{data[:route][:locations][0][:adminArea3]}"
    @end_point = "#{data[:route][:locations][1][:adminArea5]}, #{data[:route][:locations][1][:adminArea3]}"
    @lat = data[:route][:locations][1][:displayLatLng][:lat]
    @lon = data[:route][:locations][1][:displayLatLng][:lng]
    @time = travel_time_in_hours(data[:route][:time])
    @weather_on_arrival = arrival_weather(data, forecast)
    @temp_on_arrival = arrival_temp(data, forecast)
  end
  
  def travel_time_in_hours(seconds)
     time = Time.at(seconds).utc.strftime('%H').to_i
  end

  def arrival_weather(data, forecast)
    binding.pry
    if @time < 24 
      forecast[:hourly][@time][:weather][0][:description]
    else @time >=
      forecast[:daily][1][:weather][0][:description]
    end 
  end

  def arrival_temp(data, forecast)
  
    if @time < 24 
      forecast[:hourly][@time][:temp]
    else @time >= 24 
      forecast[:daily][1][:temp][:day]
    end
  end

end