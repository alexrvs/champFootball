class CreateTeamsMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :teams_matches do |t|
      t.integer :team_id
      t.integer :matches_id
      t.timestamps
    end
  end
end
