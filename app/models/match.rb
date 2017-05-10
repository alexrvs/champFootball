class Match < ApplicationRecord
    belongs_to :first_team , :foreign_key => 'team1_id', :class_name => 'Team'
    belongs_to :second_team, :foreign_key => 'team2_id', :class_name => 'Team'
    belongs_to :round, :class_name => 'Round'
    belongs_to :tournament, :class_name => 'Tournament'

    # scope :team, -> (team1_id, team2_id) {where('teams.')}

  def teams
      Team.select('*').joins('LEFT JOIN matches ON (teams.id  = matches.team1_id OR teams.id = matches.team2_id)').where(['matches.id = ?', self.id])
  end
end

