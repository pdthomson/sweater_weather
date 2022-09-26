class Api::V1::BookSearchController < ApplicationController
  before_action :location_check

  def index
    location = params[:location]
    quantity = params[:quantity].to_i
    forecast = ForecastFacade.forecast(@coordinates.lat, @coordinates.lon)
    books = BookFacade.find_books(location)
    if quantity <= books[:numFound]
      render json: BookSerializer.book(forecast, books, location, quantity)
    else 
      return invalid_quantity 
    end
  end

  def location_check
    if params[:location].present? 
      @coordinates = MapFacade.coordinates(params[:location])
    else 
      render status: 404
    end
  end

  private 

  def invalid_quantity 
    render json: { data: { message: 'Invalid Quantity'}}
  end
end