class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :score
      t.integer :player_id
      t.integer :game_id
      t.integer :group_id

      t.timestamps
    end
  end
end
