class UserRank < ApplicationRecord

  scope :avg_rank, ->(user_id){

    UserRank.select('AVG(rank) as mid_rank').where('user_id = ?',user_id)
  }
end
