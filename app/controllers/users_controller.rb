class UsersController < ApplicationController

  include UsersHelper

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'show'
    else
      render 'new'
    end
  end

  def login

  end

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:confirm_password)
  end
end
