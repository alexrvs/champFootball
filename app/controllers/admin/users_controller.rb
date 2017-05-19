class Admin::UsersController < ApplicationController

  before_action :find_user, only: [:edit, :destroy, :update]

  layout 'admin/admin'

  def index
    @users = User.without_admin
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to :action => 'index'
    else
    render 'edit'
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
