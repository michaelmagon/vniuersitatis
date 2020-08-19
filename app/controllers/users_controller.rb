class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    
    if @user
      render json: @user, status: 200 and return
    else
      render json: @user.errors, status: 500 and return
    end
  end
end