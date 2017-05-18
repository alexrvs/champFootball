class Admin::MatchesController < ApplicationController

  layout 'admin/admin'

  before_action :find_match, only: [:show, :destroy, :edit, :update]

  def index
      @matches = Match.where(nil).order(:id)  # creates an anonymous scope
      @matches = @matches.with_team( params[:match][:team_name]).order(:id) if params[:match][:team_name].present?
      @matches = @matches.with_player(params[:match][:player_name]).order(:id) if params[:match][:player_name].present?
  end

  def index_generate
    @teams = Team.all
  end

  def show
  end

  def destroy
    @match.destroy
  end

  def edit
  end

  def update

    if @match.update_attributes!(match_params)
      redirect_to  :action => 'index'
    else
      render :edit
    end

  end

  # Generate matches

  def generate

    Match.generate_matches
    redirect_to :controller => 'matches', :action => 'index'
  end

  private

  def find_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:team1_score, :team2_score, :team1_count_goals, :team2_count_goals)
  end
  
end
