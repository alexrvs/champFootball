class WelcomeController < ApplicationController

  layout 'application'

  def index

    @tournaments = Tournament.all
    @teams = Team.all

  end

  def tournaments
    @tournaments = Tournament.all

  end

  def teams
    @teams = Team.all
  end

  def show

  end

  def users
    @users = User.without_admin.order(:rank)

  end

end
