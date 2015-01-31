class Player < ActiveRecord::Base

	def scores(span = nil)
		case span.class.name
		when "LeagueNight"
			gp = GroupPlayer.where(player_id: self.id, group_id: Group.where(league_night: span).collect(&:id)).first
			if gp
				Score.where(group: gp.group, player: self)
			else
				0
			end
		when "Group"
			Score.where(group: span, player: self)
		when "League"
			Score.where(player: self)
		end
	end

	def score_distribution(span = nil)
		scores(span)
		h = Hash.new(0)
		scores(span).each { |s| h[s.points_awarded] += 1 }
		h
	end

	# by week or league
	def points(span = nil)
		return 0 if scores(span) == 0
		scores(span).sum(&:points_awarded) + bonus_points(span)
	end

	def bonus_points(span = nil)
		case span.class.name
		when "LeagueNight"
			span.bonus_points.count {|bp| bp.player == self}
		when "League"
			span.bonus_points.count {|bp| bp.player == self}
		else

		end
	end

	def average_score(league)
		(points(league) / games_played(league).to_f).round(2)	
	end

	def games_played(league)
		Score.where(player_id: self, league_game_id: LeagueGame.where(league_night_id: league.league_nights)).count
	end
end
