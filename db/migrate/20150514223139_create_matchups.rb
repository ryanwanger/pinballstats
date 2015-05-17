class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.integer :league_night_id

      t.timestamps
    end
  end
end
