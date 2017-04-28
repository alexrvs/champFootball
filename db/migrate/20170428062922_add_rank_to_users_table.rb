class AddRankToUsersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :rank, :integer
  end
end
