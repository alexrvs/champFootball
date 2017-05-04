class Match < ApplicationRecord
    belongs_to :first_team , :foreign_key => 'team1_id', :class_name => 'Team'
    belongs_to :second_team, :foreign_key => 'team2_id', :class_name => 'Team'
end
