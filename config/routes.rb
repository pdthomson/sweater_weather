Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :forecast, only: [:index]
      resources :users, only: [:create, :new]
      resources :sessions, only: [:create, :new]
      resources :road_trip, only: [:create]
    end 
  end
end
