class LeagueNight < ActiveRecord::Base
	belongs_to :league
	has_many :league_games
	has_many :groups

	def dropdown_title
		self.league.title + " " + self.date.to_s
	end

	def player_count
		GroupPlayer.where(group_id: self.groups.collect(&:id)).count
	end
end
