class Score < ActiveRecord::Base
	belongs_to :player
	belongs_to :league_game
	belongs_to :group

	# after_save :calculate_points

	def points_awarded
		group_scores = Score.where(league_game: league_game, group: group).order("score asc").collect(&:score)
		players_in_group = group_scores.count
		points = group_scores.index(self.score) + 1
		points += 1 if players_in_group == 3 && self.score > group.group_median(league_game)
		
		return points
	end

	def calculate_points
		self.league_game.scores.where(group: self.group).each do |score|
			score.update_column(:points, score.points_awarded)
		end
	end
end
