class Api::V1::SessionsController < ApplicationController
  
  def create 
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      render json: UserSerializer.create_user(user), status: 200
    else
      render json: { error: 'Email or password is incorrect'}, status: 400
    end
  end

end