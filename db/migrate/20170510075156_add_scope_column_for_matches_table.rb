class AddScopeColumnForMatchesTable < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :team1_scope, :integer, :default => 0
    add_column :matches, :team2_scope, :integer, :default => 0
  end
end
