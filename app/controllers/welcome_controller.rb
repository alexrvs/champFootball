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
    unless params[:team].nil?
      @teams = Team.with_player(params[:team][:player_name], params[:team][:player_name])
    else
      @teams = Team.all
    end

  end

  def show

  end

  def users
    @users = User.without_admin.order(:rank)

  end


  def teams_params
    params.require(:team).permit(:player_name)
  end

end
