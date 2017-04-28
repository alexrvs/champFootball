class RemoveUserIdFromTeam < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :id_user1
    remove_column :teams, :id_user2
  end
end
