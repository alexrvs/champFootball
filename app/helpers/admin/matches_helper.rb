module Admin::MatchesHelper

  def count_matches(team1_id, team2_id)
    @match = Match.find_by(:team1_id => team1_id, :team2_id => team2_id)
    return @match.count_matches
  end

  def first_team_with_players_name(match)
      match.first_team.name.to_s +  '( ' + match.first_team.first_player.first_name.to_s + '.' +
      match.first_team.first_player.last_name.chars.first.capitalize.to_s + ' - ' +
      match.first_team.second_player.first_name.to_s +  '.' +
      match.first_team.second_player.last_name.chars.first.capitalize.to_s + ' ) '
  end

  def second_team_with_players_name(match)
      match.second_team.name.to_s +  '( ' + match.second_team.first_player.first_name.to_s + '.' +
      match.second_team.first_player.last_name.chars.first.capitalize.to_s + ' - ' +
      match.second_team.second_player.first_name.to_s +  '.' +
      match.second_team.second_player.last_name.chars.first.capitalize.to_s + ' ) '
  end

end
