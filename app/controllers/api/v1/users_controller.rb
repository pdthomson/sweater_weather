class Api::V1::UsersController < ApplicationController
  
  def create
    user = User.create(user_params)
    if user.save
      render json: UserSerializer.create_user(user), status: 201
    else
      render json: { error: 'Email is taken or left blank or passwords do not match'}, status: 400
    end
  end

  private 
  
  def user_params 
    params.permit(:email, :password, :password_confirmation)
  end

end