class Team < ApplicationRecord
  has_many :users
  belongs_to  :team_match
end
