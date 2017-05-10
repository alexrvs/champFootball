class Team < ApplicationRecord

  belongs_to :first_player , :foreign_key => 'user1_id', :class_name => 'User'
  belongs_to :second_player, :foreign_key => 'user2_id', :class_name => 'User'

  # has_many :matches1, :class_name => 'Match', foreign_key: 'team1_id', dependent: :nullify
  # has_many :matches2, :class_name => 'Match', foreign_key: 'team2_id', dependent: :nullify

  scope :matches_with, -> (name) {
    Match.select('*').joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)').where(" teams.name LIKE ? ", "#{name}%")
  }

  def matches
    Match.select('*').joins('LEFT JOIN teams ON (teams.id = matches.team1_id OR teams.id = matches.team2_id)').where(['teams.id = ?', self.id])
  end

end
