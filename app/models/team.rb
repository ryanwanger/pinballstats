class Team < ActiveRecord::Base
  belongs_to :league_night
  belongs_to :matchup

  def total_score(league_game)
    Score.where(league_game: league_game, player_id: players).sum(:score) #TODO: why must this be player_id?
  end

  def opponent
    teams = Team.where(matchup: self.matchup)
    teams.to_a.delete(self)
    teams.first
  end

  def players
    TeamPlayer.where(team: self).collect(&:player)
  end
end
