class Api::V1::SessionsController < ApplicationController
  
  def create 
    user = User.find_by_email(session_params[:email])
    if user&.authenticate(params[:password])
      render json: UserSerializer.create_user(user), status: 200
    else
      json_response({ message: 'Email or password is incorrect'}, 400)
    end
  end

  private 

  def session_params 
    params.require(:email)
    params.require(:password)
    params.permit(:email, :password)
  end

end