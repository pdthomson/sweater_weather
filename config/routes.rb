Rails.application.routes.draw do
  resources :forecast, only: [:index]
end
