class UpdateTypeColumnTournament < ActiveRecord::Migration[5.0]
  def change
    remove_column :tournaments, :type, :integer
    add_column :tournaments, :status, :integer
  end
end
