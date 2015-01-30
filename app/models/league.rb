class League < ActiveRecord::Base
	has_many :league_nights

	def players
		@players = Player.where(id: GroupPlayer.where(group_id: Group.where(league_night_id: league_nights)).collect(&:player_id))
		@players.sort_by {|p| p.points}

	end
end
