class UserRank < ApplicationRecord

  scope :avg_rank, ->(user_id){

    where('user_id = ?',user_id).average(:rank)
  }
end
