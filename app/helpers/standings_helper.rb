module StandingsHelper

  attr_accessor :standings


  def self.load(team)
    @standings = Team.standings(team.id).first
  end

  def self.position
    @standings.all_team1_score.to_i + @standings.all_team2_score.to_i
  end

  def self.count_matches_all
     @standings.count_matches_all
  end

  def self.count_wins
    @standings.team_count_wins1.to_i + @standings.team_count_wins2.to_i
  end

  def self.count_lose
    @standings.count_matches_lose1.to_i + @standings.count_matches_lose2.to_i
  end

  def self.all_team_score
    @standings.all_team1_score.to_i + @standings.all_team2_score.to_i
  end

  def self.missed_goals
    @standings.all_missed_goals1.to_i + @standings.all_missed_goals2.to_i
  end

  def self.scored_goals
    @standings.all_scored_goals1.to_i + @standings.all_scored_goals2.to_i
  end

  def self.score_conceded_goals
    (@standings.all_scored_goals1.to_i + @standings.all_scored_goals2.to_i).to_s + ' - ' + (@standings.all_missed_goals1.to_i + @standings.all_missed_goals2.to_i).to_s
  end

  def self.difference_goals
    (@standings.all_scored_goals1.to_i + @standings.all_scored_goals2.to_i).to_i  - (@standings.all_missed_goals1.to_i + @standings.all_missed_goals2.to_i).to_i
  end

  def self.points
    @standings.all_team1_score.to_i + @standings.all_team2_score.to_i
  end
end