class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :league_night_id
      t.integer :player_id
      t.integer :group_rank

      t.timestamps
    end
  end
end
