class UserRank < ApplicationRecord

  scope :avg_rank, ->(user_id){

    where('user_id = ?',user_id).average(:rank)
  }

  def self.new_vote(records)

      self.create(records)
  end

end
