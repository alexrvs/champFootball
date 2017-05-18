class Admin::StandingsController < ApplicationController

  layout 'admin/admin'

  include StandingsHelper

  def index
    @teams = Team.all

    @allTeam = Array.new
    @teams.each do |team|
      @hash = Hash.new
      standings = Team.standings(team.id).first
      @hash["position"] = standings.all_team1_score.to_i + standings.all_team2_score.to_i
      @hash["name"] = team.name
      @hash["count_matches_all"] = standings.count_matches_all
      @hash["wins"] = standings.team_count_wins1.to_i + standings.team_count_wins2.to_i
      @hash["lose"] = standings.count_matches_lose1.to_i + standings.count_matches_lose2.to_i
      @hash["score_conceded_goals"] = (standings.all_scored_goals1.to_i + standings.all_scored_goals2.to_i).to_s + ' - ' + (standings.all_missed_goals1.to_i + standings.all_missed_goals2.to_i).to_s
      @hash["difference_goals"] = (standings.all_scored_goals1.to_i + standings.all_scored_goals2.to_i).to_i  - (standings.all_missed_goals1.to_i + standings.all_missed_goals2.to_i).to_i
      @hash["points"] = standings.all_team1_score.to_i + standings.all_team2_score.to_i
      @allTeam << @hash
    end

  end

end
