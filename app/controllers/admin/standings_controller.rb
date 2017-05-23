class Admin::StandingsController < ApplicationController

  layout 'admin/admin'

  include StandingsHelper

  def index

    @teams = Team.all
    @allTeam = Array.new
    @teams.each do |team|
      @st = StandingsHelper.load team
      @hash = Hash.new
      @hash["position"] = StandingsHelper.position
      @hash["name"] = team.name
      @hash["count_matches_all"] = StandingsHelper.count_matches_all
      @hash["wins"] = StandingsHelper.count_wins
      @hash["lose"] = StandingsHelper.count_lose
      @hash["score_conceded_goals"] = StandingsHelper.score_conceded_goals
      @hash["difference_goals"] = StandingsHelper.difference_goals
      @hash["points"] = StandingsHelper.points
      @allTeam << @hash
    end
    @allTeam = @allTeam.sort{|hash1,hash2| hash1["position"] <=> hash2["position"]}.reverse
  end

end
