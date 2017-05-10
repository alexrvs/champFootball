class Match < ApplicationRecord

    belongs_to :first_team , :foreign_key => 'team1_id', :class_name => 'Team'
    belongs_to :second_team, :foreign_key => 'team2_id', :class_name => 'Team'
    belongs_to :round, :class_name => 'Round'
    belongs_to :tournament, :class_name => 'Tournament'



    scope :with_team, -> (name) {
        Match.select('*').joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)').where(" teams.name LIKE ? ", "#{name}%")
    }

    scope :with_player, -> (player){
        Match.select('*').joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)
                                 LEFT JOIN users ON (users.id = teams.user1_id OR users.id = teams.user2_id )')
                        .where('users.first_name LIKE ? OR users.last_name LIKE ?', "#{player}%", "#{player}%")
    }
  def teams
      Team.select('*').joins('LEFT JOIN matches ON (teams.id  = matches.team1_id OR teams.id = matches.team2_id)').where(['matches.id = ?', self.id])
  end
end

