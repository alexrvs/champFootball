class DropTableTeamMatches < ActiveRecord::Migration[5.0]
  def change
    drop_table :team_matches
  end
end
