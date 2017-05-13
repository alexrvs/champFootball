class AddUserIdRankdTournamentIdToUserRanks < ActiveRecord::Migration[5.0]
  def change
    add_column :user_ranks, :user_vote_id, :integer
    add_column :user_ranks, :tournament_id, :integer
    add_column :user_ranks, :user_id, :integer
    add_column :user_ranks, :rank, :integer
  end
end
