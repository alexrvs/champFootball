class AddCountMatchesColumnToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :count_matches, :integer
  end
end
