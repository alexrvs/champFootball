class ChangeScoreColumnMatchesTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :matches, :team1_scope
    remove_column :matches, :team2_scope
    add_column :matches, :team1_score, :integer, :default => 0
    add_column :matches, :team2_score, :integer, :default => 0
  end
end
