class Match < ApplicationRecord
    belongs_to :first_team , :foreign_key => 'team1_id', :class_name => 'Team'
    belongs_to :second_team, :foreign_key => 'team2_id', :class_name => 'Team'

  def teams
      Team.select('*').joins('LEFT JOIN matches ON (teams.id  = matches.team1_id OR teams.id = matches.team2_id)').where(['matches.id = ?', self.id])
  end
end

