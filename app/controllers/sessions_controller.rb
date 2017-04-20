class SessionsController < ApplicationController

  include SessionsHelper

  def new
    @user = User.new
  end

  def create

    user = User.find_by_email(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      signin_user
      redirect_to_user
    else
      flash.now[:error] = "Invalid email or password"
      render 'new'
    end

  end

  def destroy

  end

end
