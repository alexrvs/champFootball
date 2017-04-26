class CreateTournamentTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :tournament_teams do |t|
      t.integer :id_team
      t.integer :id_tournament

      t.timestamps
    end
  end
end
