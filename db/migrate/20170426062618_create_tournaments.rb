class CreateTournaments < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :description
      t.integer :type
      t.timestamps
    end
  end
end
