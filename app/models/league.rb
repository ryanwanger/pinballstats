class League < ActiveRecord::Base
	has_many :league_nights, order: "week_number asc"

	def players
		players = Player.where(id: GroupPlayer.where(group_id: Group.where(league_night_id: league_nights)).collect(&:player_id))
		players.sort_by {|p| [p.average_score(self), p.score_distribution(self)[4], p.score_distribution(self)[3], p.score_distribution(self)[2]]}.reverse
	end

	def bonus_points
		bonus_points = []
		league_nights.each do |league_night|
			league_night.league_games.each do |league_game|
				bonus_points << league_game.scores.first
			end
		end
		bonus_points
	end
end
