class Admin::BaseController < ApplicationController
  layout 'admin/admin'
  include SessionsHelper
  include UsersHelper

  def index
    flash.now[:success] = "Admin Panel"
  end

  def login

  end

end
