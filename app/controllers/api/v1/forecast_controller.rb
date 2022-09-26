class Api::V1::ForecastController < ApplicationController
    
    def index
      location = MapFacade.coordinates(forecast_params[:location])
      weather = ForecastFacade.forecast(location.lat, location.lon)
      render json: ForecastSerializer.forecast(weather)
    end

    private 

    def forecast_params
      params.require(:location)
      params.permit(:location)
    end

end