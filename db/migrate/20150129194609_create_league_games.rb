class CreateLeagueGames < ActiveRecord::Migration
  def change
    create_table :league_games do |t|
      t.integer :game_id
      t.integer :league_night_id
      t.timestamps
    end
  end
end
