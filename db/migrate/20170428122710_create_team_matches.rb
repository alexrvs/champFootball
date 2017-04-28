class CreateTeamMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :team_matches do |t|

      t.timestamps
    end
  end
end
