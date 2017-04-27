class Admin::UsersController < ApplicationController

  layout 'admin/admin'


  def index
    # @users = User.find_by(is_admin: nil)
    @users = User.all
  end


  def show
    @user = User.find(params[:id])

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :action => 'show', :id => @user.id
    else
      render :action => 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to :action => 'show', :id => @user.id
    elsif
    render 'update'
    end
  end


  def user_params
    params.require(:user).permit(:first_name,:last_name,:email)
  end


end
