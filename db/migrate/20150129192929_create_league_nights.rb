class CreateLeagueNights < ActiveRecord::Migration
  def change
    create_table :league_nights do |t|
      t.date :date
      t.integer :league_id
      t.integer :location_id

      t.timestamps
    end
  end
end
