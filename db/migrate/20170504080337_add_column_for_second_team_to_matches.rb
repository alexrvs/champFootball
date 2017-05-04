class AddColumnForSecondTeamToMatches < ActiveRecord::Migration[5.0]
  def change
    remove_column :matches, :team_id
    add_column :matches, :team1_id, :integer
    add_column :matches, :team2_id, :integer
  end
end
