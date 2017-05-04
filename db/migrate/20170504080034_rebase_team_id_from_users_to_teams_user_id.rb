class RebaseTeamIdFromUsersToTeamsUserId < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :team_id
    add_column :teams, :user1_id, :integer
    add_column :teams, :user2_id, :integer
  end
end
