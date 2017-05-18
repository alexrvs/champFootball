class Match < ApplicationRecord

    belongs_to :first_team , :foreign_key => 'team1_id', :class_name => 'Team'
    belongs_to :second_team, :foreign_key => 'team2_id', :class_name => 'Team'
    belongs_to :round, :class_name => 'Round'
    belongs_to :tournament, :class_name => 'Tournament'



    scope :with_team, -> (name) {
        joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)').where(' teams.name LIKE :name ', {name: "#{name}%"})
    }

    scope :with_player, -> (player_name){
        joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)')
        .joins('LEFT JOIN users ON (users.id = teams.user1_id OR users.id = teams.user2_id )')
        .where('users.first_name LIKE :name OR users.last_name LIKE :name', {name: "#{player_name}%"})
    }

    scope :search_by_team_and_player, -> (team_name, player_name){

        joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)
                                 LEFT JOIN users ON (users.id = teams.user1_id OR users.id = teams.user2_id )')
          .where('(users.first_name LIKE :player_name OR users.last_name LIKE :player_name) AND teams.name LIKE :team_name', {team_name: "#{team_name}%", player_name: "#{player_name}%"})
    }

  def teams
      Team.select('*').joins('LEFT JOIN matches ON (teams.id  = matches.team1_id OR teams.id = matches.team2_id)').where(['matches.id = ?', self.id])
  end

  def self.get_id_current_tournament
      Tournament.select('*').joins('LEFT JOIN tournament_types ON tournament_types.id = tournaments.tournament_type_id').where('tournament_types.name = \'current\'')
  end

  def self.generate_matches

    @current_tournament_id = self.get_id_current_tournament
    @current_round = Round.first

    @teamsIds = Team.all.ids
    @teamCouple = @teamsIds.combination(2).to_a

    @teamCouple.each do |t1_c_id, t2_c_id|
      @match = self.new
      @match.tournament_id = @current_tournament_id.ids
      @match.round_id = @current_round.id
      @match.team1_id = t1_c_id
      @match.team2_id = t2_c_id
      @match.count_matches = 1
      @match.save
    end
  end

end

