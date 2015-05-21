class Player < ActiveRecord::Base

	def self.expected_points(recent_weeks = 8, league = League.last)
		league.players.sort!{|a,b| b.expected_points(recent_weeks) <=> a.expected_points(recent_weeks)}.each{|p| puts p.name; puts p.expected_points(recent_weeks); puts}
	end

	def expected_points(recent_weeks = 8)
		scores = Score.where(player_id: id).order(:created_at).last(recent_weeks * 5).collect(&:percent_of_average)
		(scores.inject{|sum,x| sum + x }.to_f / scores.count).round(2)
	end

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

			Score.where(player: self).where(league_game_id: LeagueGame.where(league_night_id: span.league_nights) )
		end
	end

	def score_distribution(span = nil)
		scores(span)
		h = Hash.new(0)
		scores(span).each { |s| h[s.points] += 1 }
		h
	end

	# by week or league
	def points(span = nil)
		return 0 if scores(span) == 0
		scores(span).sum(&:points) + bonus_points(span).to_i
	end

	def bonus_points(span = nil)
		span.bonus_points.count {|bp| bp.try(:player_id) == self.id}
	end

	def average_score(league)
		sprintf "%.2f", (points(league) / scores(league).count.to_f)
	end

	def games_played(league)
		Score.where(player_id: self, league_game_id: LeagueGame.where(league_night_id: league.league_nights)).count
	end

	def group(league_night)
		gp = GroupPlayer.where(player_id: self, group_id: league_night.groups.collect(&:id))
		if gp.first
			gp.first.group
		else
			nil
		end
	end
end
