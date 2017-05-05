class Team < ApplicationRecord
  belongs_to :first_player , :foreign_key => 'user1_id', :class_name => 'User'
  belongs_to :second_player, :foreign_key => 'user2_id', :class_name => 'User'

  # has_many :matches1, :class_name => 'Match', foreign_key: 'team1_id', dependent: :nullify
  # has_many :matches2, :class_name => 'Match', foreign_key: 'team2_id', dependent: :nullify

  def matches
    Match.where('team1_id => ? OR team2_id => ?', self.id, self.id)
  end
end
