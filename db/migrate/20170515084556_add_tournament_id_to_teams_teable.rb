class AddTournamentIdToTeamsTeable < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :tournament_id, :integer
  end
end
