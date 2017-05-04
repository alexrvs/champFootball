class AddForeignKeyToTeamTable < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :teams, :users, column: :user1_id, primary_key: :id
    add_foreign_key :teams, :users, column: :user2_id, primary_key: :id
  end
end
