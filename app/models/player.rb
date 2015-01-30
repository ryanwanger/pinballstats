class Player < ActiveRecord::Base

	def points(group = nil)
		if group
			Score.where(group: group, player: self).sum(&:points_awarded)
		else
			Score.where(player: self).sum(&:points_awarded)
		end
	end

	def average_score(league)
		(points / total_games.to_f).round(2)	
	end

	def games_played(league)
		Score.where(player_id: self, league_game_id: LeagueGame.where(league_night_id: league.league_nights)).count
	end
end
