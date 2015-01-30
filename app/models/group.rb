class Group < ActiveRecord::Base
	belongs_to :league_night
	has_many :group_players
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
		end
	end

	def groups_from_bottom
		league_night.groups.count - group_rank 
	end

	def group_median(league_game)
		nth_score = (league_night.player_count * group_median_percentage).ceil
		puts "nth score: " + nth_score.to_s + " for league_game " + league_game.game.title
		Score.where(league_game: league_game).order("score desc").offset(nth_score).first.score
	end
end
