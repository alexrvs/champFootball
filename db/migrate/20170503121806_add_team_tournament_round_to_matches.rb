class AddTeamTournamentRoundToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :team_id, :integer
    add_column :matches, :tournament_id, :integer
    add_column :matches, :round_id, :integer
  end
end
