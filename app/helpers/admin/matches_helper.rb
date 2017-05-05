module Admin::MatchesHelper

  def count_matches(team1_id, team2_id)
    @match = Match.find_by(:team1_id => team1_id, :team2_id => team2_id)
    return @match.count_matches
  end
end
