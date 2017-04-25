class Admin::BaseController < ApplicationController
  layout 'admin/admin'
  def index
    flash.now[:success] = "Admin Panel"
  end

end
