class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]

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
      flash.now[:success] = "Profile created"
      sign_in(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash.now[:success] = "Profile successful updated!"
      redirect_to @user
    elsif
      flash.now[:error] = "Please try agailn to update profile!"
      render 'edit'
    end
  end

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
  end

  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

end
