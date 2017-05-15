class Tournament < ApplicationRecord
   belongs_to :tournament_type
   has_many :matches
   has_many :teams


    scope :with_new_teams, -> (tournament_id){
      Tournament.select('*').joins('LEFT JOIN teams ON teams.tournament_id = tournaments.id').where(' teams.tournament_id <> ?', tournament_id)
    }

    scope :with_teams, -> (){
       Team.select('*').where('tournament_id IS NULL')
    }

    scope :with_status, -> (status){
      Tournament.select('*').joins('LEFT JOIN tournament_types ON tournament_types.id = tournaments.tournament_type_id').where('tournament_types.name = ?',status)
    }

end
