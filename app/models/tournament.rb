class Tournament < ApplicationRecord
   belongs_to :tournament_type
   has_many :matches
   has_many :teams


  scope :with_new_teams, -> (tournament_id){
    Tournament.select('*').joins('LEFT JOIN teams ON teams.tournament_id = tournament.id').where('teams.tournament_id <> ? AND tournament.id = ?',tournament_id, tournament_id)
  }


end
