class AddForeignKeyToMatchesTable < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :matches, :teams, column: :team1_id, primary_key: :id
    add_foreign_key :matches, :teams, column: :team2_id, primary_key: :id
  end
end
