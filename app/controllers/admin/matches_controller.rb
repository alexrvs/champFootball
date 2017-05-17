class Admin::MatchesController < ApplicationController

  layout 'admin/admin'

  def index
    if params[:match].present?
      @matches = Match.where(nil).order(:id)  # creates an anonymous scope
      @matches = Match.with_team( params[:match][:team_name]).order(:id) if params[:match][:team_name].present?
      @matches = Match.with_player(params[:match][:player_name]).order(:id) if params[:match][:player_name].present?
      @matches = Match.search_by_team_and_player(params[:match][:team_name], params[:match][:player_name]).order(:id) if params[:match][:team_name].present? && params[:match][:player_name]
    else
      @matches = Match.order(:id)
    end
  end

  def index_generate
    @teams = Team.all
  end

  def show
    @match = Match.find(params[:id])
  end


  def destroy
    @match = Match.find(params[:id])

  end

  def edit
    @match = Match.find(params[:id])
  end

  def update

    @match = Match.find(params[:id])

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

  def match_params
    params.require(:match).permit(:team1_score, :team2_score, :team1_count_goals, :team2_count_goals)
  end
  
end
