class AddTeamIdMatchIdToTeamMatchTable < ActiveRecord::Migration[5.0]
  def change
    add_column :team_matches, :team_id, :integer
    add_column :team_matches, :match_id, :integer
  end
end
