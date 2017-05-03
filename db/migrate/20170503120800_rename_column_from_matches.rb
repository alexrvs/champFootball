class RenameColumnFromMatches < ActiveRecord::Migration[5.0]
  def change
    remove_column :matches, :id_team
    remove_column :matches, :id_tournament
    remove_column :matches, :id_round
  end
end
