class Team < ApplicationRecord
  has_many :users
  belongs_to  :teams_match
end
