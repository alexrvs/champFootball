class CreateUserRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_ranks do |t|

      t.timestamps
    end
  end
end
