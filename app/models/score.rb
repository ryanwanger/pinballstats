class Score < ActiveRecord::Base
	belongs_to :player
	belongs_to :league_game
	belongs_to :group

	def points_awarded
		group_scores = Score.where(league_game: league_game, group: group).order("score asc").collect(&:score)
		players_in_group = group_scores.count
		points = group_scores.index(self.score) + 1
		points += 1 if players_in_group == 3 && self.score > group.group_median(league_game)
		# points += 1 if bonus_point?
		
		return points
	end

	def bonus_point?
		Score.where(league_game: league_game).order("score desc").first.player == self.player
	end
end
