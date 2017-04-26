class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :id_team
      t.integer :id_tournament
      t.integer :id_round

      t.timestamps
    end
  end
end
