class Team < ApplicationRecord
  belongs_to :first_player , :foreign_key => 'user1_id', :class_name => 'User'
  belongs_to :second_player, :foreign_key => 'user2_id', :class_name => 'User'
  belongs_to  :teams_match
  has_many :matches
end
