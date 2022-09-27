class Api::V1::RoadTripController < ApplicationController
  
  def create 
    road_trip = MapFacade.roadtrip(trip_params[:origin], trip_params[:destination])
    if !trip_params[:api_key] 
      json_response( {message: ''}, 401)
    elsif road_trip == 'impossible route'
      render json: RoadTripSerializer.impossible_route(trip_params[:origin], trip_params[:destination])
    else 
      forecast = ForecastFacade.forecast(road_trip.lat, road_trip.lon)
      render json: RoadTripSerializer.create_roadtrip(road_trip, forecast)
    end
  end

  private 

  def trip_params 
    params.require(:origin)
    params.require(:destination)
    params.permit(:origin, :destination, :api_key)
  end
end