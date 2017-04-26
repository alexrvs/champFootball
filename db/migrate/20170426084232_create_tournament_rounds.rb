class CreateTournamentRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :tournament_rounds do |t|
      t.integer :id_tournament
      t.integer :id_round

      t.timestamps
    end
  end
end
