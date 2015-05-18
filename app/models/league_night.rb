class LeagueNight < ActiveRecord::Base
	belongs_to :league
	belongs_to :location
	has_many :league_games
	has_many :groups
	has_many :matchups

	after_create :set_week_number

	def dropdown_title
		self.league.title + " " + self.date.to_s
	end

	def player_count
		GroupPlayer.where(group_id: self.groups.collect(&:id)).count
	end

	def bonus_points
		bonus_points = []
		league_games.each do |league_game|
			bonus_points << league_game.scores.first
		end
		bonus_points
	end

	def set_week_number
		self.update_column(:week_number, self.league.league_nights.count)
	end
end
