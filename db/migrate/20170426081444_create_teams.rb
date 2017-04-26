class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :description
      t.integer :id_user1
      t.integer :id_user2
      t.integer :points_count

      t.timestamps
    end
  end
end
