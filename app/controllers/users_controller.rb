class UsersController < ApplicationController

  include UsersHelper

  def show
    flash.now[:success] = "Profile Page"
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = "Profile created"
      redirect_to @user
    else
      render 'new'
    end
  end

  def login

  end

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
  end
end
