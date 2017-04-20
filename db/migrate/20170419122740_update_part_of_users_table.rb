class UpdatePartOfUsersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string, after: :id
    add_column :users, :last_name, :string, after: :first_name
    remove_column :users, :name
  end
end
