class AddTeamWinToScores < ActiveRecord::Migration
  def change
  	add_column :scores, :team_win, :boolean, default: false
  end
end
