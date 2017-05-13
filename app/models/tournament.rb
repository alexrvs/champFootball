class Tournament < ApplicationRecord
   belongs_to :tournament_type
   has_many :matches
   has_one :tournament_type
end
