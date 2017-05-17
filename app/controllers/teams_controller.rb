class TeamsController < ApplicationController

  layout 'application'

  def index
    unless params[:team].nil?
      @teams = Team.with_player(params[:team][:player_name])
    else
      @teams = Team.all
    end

  end

  def showTeamCurrentUser
    @team = Team.find(params[:id])
  end


  def editTeamByUser
    @team =  Team.find(params[:id])
  end

  def updateTeamByUser
    @team =  Team.find(params[:id])
    if @team.update_attributes(team_user_params)
      flash.now[:success] = "Name team successful updated!"
      redirect_to :action => 'teams'
    elsif
    flash.now[:error] = "Please try agailn to update name team!"
      render 'editTeamByUser'
    end

  end

  def teams_params
    params.require(:team).permit(:player_name)
  end

  def team_user_params
    params.require(:team).permit(:name)
  end

end
