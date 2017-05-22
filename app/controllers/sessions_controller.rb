class SessionsController < ApplicationController

  include SessionsHelper

  def new
    #@user = User.new
  end

  def create

    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password]) && !user.is_admin
      sign_in user
      redirect_to user
    elsif user &&user.authenticate(params[:sessions][:password]) && user.is_admin
      sign_in user
      redirect_to admin_tournaments_path
    else
      flash.now[:error] = "Invalid email or password"
      render 'new'
    end

  end

  def createSocAuth
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.present?
      flash.now[:success] = "Profile page"
      sign_in @user
      redirect_to edit_user_path(@user)
    end

  end


  def destroy
    sign_out
    redirect_to root_url
  end



end
