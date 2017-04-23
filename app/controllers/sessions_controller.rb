class SessionsController < ApplicationController

  include SessionsHelper

  def new
    #@user = User.new
  end

  def create

    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      sign_in user
      redirect_to user
    else
      flash.now[:error] = "Invalid email or password"
      render 'new'
    end

  end

  def destroy

  end

end
