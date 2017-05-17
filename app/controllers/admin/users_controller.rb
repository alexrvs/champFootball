class Admin::UsersController < ApplicationController

  before_action :find_user, only: [:show, :destroy, :update]
  layout 'admin/admin'

  def index
    @users = User.without_admin
  end

  def show
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
    @user.destroy
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to :action => 'show', :id => @user.id
    elsif
    render 'update'
    end
  end


  def user_params
    params.require(:user).permit(:first_name,:last_name,:email)
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
