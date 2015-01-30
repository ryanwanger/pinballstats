class ChangeScoresToLeagueGame < ActiveRecord::Migration
  def change
  	rename_column :scores, :game_id, :league_game_id 
  end
end
