class ChangeMatchesIdColumnTableTeamsMatches < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams_matches, :matches_id
    add_column :teams_matches, :match_id, :integer
  end
end
