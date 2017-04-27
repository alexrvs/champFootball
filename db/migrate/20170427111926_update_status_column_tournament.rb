class UpdateStatusColumnTournament < ActiveRecord::Migration[5.0]
  def change
    remove_column :tournaments, :status, :integer
    add_column :tournaments, :tournament_type_id, :integer
  end
end
