class Team < ApplicationRecord

  belongs_to :first_player , :foreign_key => 'user1_id', :class_name => 'User'
  belongs_to :second_player, :foreign_key => 'user2_id', :class_name => 'User'
  belongs_to :tournament, :class_name => 'Tournament'

  # has_many :matches1, :class_name => 'Match', foreign_key: 'team1_id', dependent: :nullify
  # has_many :matches2, :class_name => 'Match', foreign_key: 'team2_id', dependent: :nullify

  scope :matches_with, -> (name) {
    Match.select('*').joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)').where(" teams.name LIKE ? ", "#{name}%")
  }

  scope :standings, -> (team_id) {
      find_by_sql('SELECT *,
                            (SELECT  count(*) FROM matches WHERE matches.team1_id = teams.id OR matches.team2_id = teams.id) as count_matches_all,
                            (SELECT  count(*) FROM matches WHERE (matches.team1_id = teams.id OR matches.team2_id = teams.id)
                                                                  AND matches.team1_score <> 0 OR matches.team2_score <> 0) as count_matches_wins,
                            (SELECT  count(*) FROM matches WHERE matches.team1_id = teams.id AND (matches.team1_score = 0 AND matches.team2_score > 0 )) as count_matches_lose,
                            (SELECT SUM(team1_count_goals) FROM matches  WHERE matches.team2_id <> teams.id AND matches.team1_id = teams.id GROUP BY teams.id) as all_missed_goals,
                            (SELECT SUM(team1_count_goals) FROM matches  WHERE matches.team2_id <> teams.id AND matches.team1_id = teams.id GROUP BY teams.id) as all_scored_goals,
                            (SELECT SUM(team1_score) FROM matches  WHERE matches.team1_id = teams.id GROUP BY teams.id) as all_team1_score
                          FROM teams LEFT JOIN matches ON (teams.id = matches.team1_id)
                          WHERE teams.id = ' + team_id.to_s + 'GROUP BY teams.id, matches.team1_id, matches.id')
  }

  scope :standings2, -> (team_id){
      Team.find_by_sql('SELECT *,
                  (SELECT  count(*) FROM matches WHERE matches.team1_id = teams.id OR matches.team2_id = teams.id) as count_matches_all,
                  (SELECT count(*) FROM matches LEFT JOIN teams ON (teams.id = matches.team1_id) WHERE (matches.team1_score <> 0 AND matches.team1_id IN (' + team_id.to_s + '))) as team_count_wins1,
                  (SELECT count(*) FROM matches LEFT JOIN teams ON (teams.id = matches.team2_id) WHERE (matches.team2_score <> 0 AND matches.team2_id IN (' + team_id.to_s + '))) as team_count_wins2,
                  (SELECT  count(*) FROM matches WHERE matches.team1_id = teams.id AND (matches.team1_score = 0 AND matches.team2_score > 0 )) as count_matches_lose1,
                  (SELECT  count(*) FROM matches WHERE matches.team2_id = teams.id AND (matches.team2_score = 0 AND matches.team1_score > 0 )) as count_matches_lose2,
                  (SELECT SUM(team1_score) FROM matches  WHERE matches.team1_id = teams.id GROUP BY teams.id) as all_team1_score,
                  (SELECT SUM(team2_score) FROM matches  WHERE matches.team2_id = teams.id GROUP BY teams.id) as all_team2_score,
                  (SELECT SUM(team2_count_goals) FROM matches  WHERE matches.team2_id <> teams.id AND matches.team1_id = teams.id GROUP BY teams.id) as all_missed_goals1,
                  (SELECT SUM(team1_count_goals) FROM matches  WHERE matches.team1_id <> teams.id AND matches.team2_id = teams.id GROUP BY teams.id) as all_missed_goals2,
                  (SELECT SUM(team1_count_goals) FROM matches  WHERE matches.team2_id <> teams.id AND matches.team1_id = teams.id GROUP BY teams.id) as all_scored_goals1,
                  (SELECT SUM(team2_count_goals) FROM matches  WHERE matches.team1_id <> teams.id AND matches.team2_id = teams.id GROUP BY teams.id) as all_scored_goals2
                FROM matches
                  LEFT JOIN teams ON (teams.id = matches.team2_id OR teams.id = matches.team2_id)
                WHERE teams.id = ' + team_id.to_s + ' GROUP BY teams.id, matches.team1_id, matches.id LIMIT 1
')

  }


  scope :with_player, -> (name){
      joins('LEFT JOIN users ON (users.id = teams.user1_id OR users.id = teams.user2_id)').where('users.first_name LIKE :name OR  users.last_name LIKE :name', {name: "#{name}%"})
  }

  scope :with_current_user, -> (user_id){
    where('teams.user1_id = :user_id OR teams.user2_id = :user_id', {user_id: user_id})
  }

  def matches
    Match.select('*').joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)').where(['teams.id = ?', self.id])
  end

  def self.generate

    @usersTeam = User.without_admin.to_a
    @countTeams = (@usersTeam.count/2).to_i
    @allTeam = Array.new
    @tournament_id = Tournament.with_status('open').first.id

    @countTeams.times do |i|

      first_player = @usersTeam.max { |a, b| a.rank <=> b.rank }
      @usersTeam.delete_if{|u| u.id == first_player.id}
      second_player = @usersTeam.min { |a, b| a.rank <=> b.rank }
      @usersTeam.delete_if{|u| u.id == second_player.id}

      @teamItem = Hash.new
      @teamItem["name"] = self.full_team_name(first_player, second_player)
      @teamItem["description"] = 'Default Description ' + @teamItem["name"].to_s
      @teamItem["points_count"] = (i+1).to_i
      @teamItem["user1_id"] = first_player.id
      @teamItem["user2_id"] = second_player.id
      @teamItem["tournament_id"] = @tournament_id
      @allTeam << @teamItem

    end
      self.create(@allTeam)
  end

  def self.full_team_name(first_player, second_player)
    first_player.last_name.chars.first.capitalize.to_s  + ' ' + first_player.last_name.chars.first.capitalize.to_s + ' + '
    + second_player.last_name.chars.first.capitalize.to_s  + ' ' + second_player.last_name.chars.first.capitalize.to_s
  end


end
