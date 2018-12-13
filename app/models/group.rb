class Group < ActiveRecord::Base
	belongs_to :league_night
	has_many :group_players, order: "id asc"
	has_many :players, through: :group_players
	has_many :league_games, through: :league_night

	def dropdown_title
		self.league_night.dropdown_title + " - Group: " + self.group_rank.to_s 
	end

	def group_median_percentage
		case groups_from_bottom
		when 0
			0.75
		when 1
			0.70
		when 2
			0.65
		when 3
			0.60
		when 4
			0.55
		when 5
			0.50
		when 6
			0.45
		when 7
			0.40
		end
	end

	def groups_from_bottom
		league_night.groups.count - group_rank 
	end

	def group_median(league_game)
		nth_score = (league_night.player_count * group_median_percentage).ceil
		Score.where(league_game: league_game).order("score desc").offset(nth_score).first.score
	end
end
