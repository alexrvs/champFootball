class TeamsController < ApplicationController

  before_action :find_teams, only: [:showTeamCurrentUser, :editTeamByUser]

  layout 'application'

  def index
    @teams = Team.where(nil).order(:id)
    @teams = @teams.with_player(params[:team][:player_name]).order(:id) if params[:team].present? && params[:team][:player_name].present?
    @teams = @teams.with_team_name(params[:team][:team_name]) if params[:team].present? && params[:team][:team_name].present?
  end

  def showTeamCurrentUser
  end

  def editTeamByUser
  end

  def updateTeamByUser
    if @team.update_attributes(team_user_params)
      flash.now[:success] = "Name team successful updated!"
      redirect_to :action => 'teams'
    elsif
    flash.now[:error] = "Please try agailn to update name team!"
      render 'editTeamByUser'
    end

  end

  def teams_params
    params.require(:team).permit(:player_name, :team_name)
  end

  def team_user_params
    params.require(:team).permit(:name)
  end

  private

  def find_teams
    @team =  Team.find(params[:id])
  end

end
