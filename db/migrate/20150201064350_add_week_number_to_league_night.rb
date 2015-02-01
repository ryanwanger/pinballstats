class AddWeekNumberToLeagueNight < ActiveRecord::Migration
  def change
  	add_column :league_nights, :week_number, :integer
  end
end
