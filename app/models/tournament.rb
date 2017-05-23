class Tournament < ApplicationRecord
   belongs_to :tournament_type
   has_many :matches
   has_many :teams


    scope :with_new_teams, -> (tournament_id){
      joins('LEFT JOIN teams ON teams.tournament_id = tournaments.id').where(' teams.tournament_id <> ?', tournament_id)
    }

    scope :with_teams, -> (){
       Team.select('*').where('tournament_id IS NULL')
    }

    scope :with_teams_by_tournament, -> (tournament_id){
      Team.select('*').joins('LEFT JOIN teams ON teams.tournament_id').where('teams.tournament_id = ?', tournament_id)
    }

    scope :with_status, -> (status){
      joins(:tournament_type).where('tournament_types.name = ?', status)
    }

end
