class Team < ApplicationRecord

  belongs_to :first_player , :foreign_key => 'user1_id', :class_name => 'User'
  belongs_to :second_player, :foreign_key => 'user2_id', :class_name => 'User'

  # has_many :matches1, :class_name => 'Match', foreign_key: 'team1_id', dependent: :nullify
  # has_many :matches2, :class_name => 'Match', foreign_key: 'team2_id', dependent: :nullify

  scope :matches_with, -> (name) {
    Match.select('*').joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)').where(" teams.name LIKE ? ", "#{name}%")
  }

  scope :standings, -> (team_id) {
    Team.find_by_sql('SELECT *, count(*) AS count_matches_all,
                            (SELECT  count(*) FROM matches WHERE matches.team1_id = teams.id AND matches.team1_score <> 0) as count_matches_wins,
                            (SELECT  count(*) FROM matches WHERE matches.team1_id = teams.id AND
                                                                 (matches.team1_score = 0 AND matches.team2_score > 0 )) as count_matches_lose,
                            (SELECT SUM(team1_score) FROM matches  WHERE matches.team1_id = teams.id GROUP BY teams.id) as all_team1_score,
                            (SELECT SUM(team2_score) FROM matches  WHERE matches.team2_id <> teams.id
                                                                         AND matches.team1_id = teams.id GROUP BY teams.id) as all_missed_goals
                          FROM teams LEFT JOIN matches ON (teams.id = matches.team1_id)
                          WHERE teams.id = ?
                          GROUP BY teams.id, matches.team1_id, matches.id',53.to_i)
  }

  def matches
    Match.select('*').joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)').where(['teams.id = ?', self.id])
  end

end
