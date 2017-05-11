class AddTowColumnForCountGoalsTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :team1_count_goals, :integer, :default => 0
    add_column :matches, :team2_count_goals, :integer, :default => 0
  end
end
