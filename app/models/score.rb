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

  def league
    league_game.league_night.league
  end

  def calculate_points
    self.league_game.scores.each do |score|
      if league.uses_matchups?
        total_scores = score.league_game.scores.where("id <> ?", score.id).count
        lower_scores = score.league_game.scores.where("score < ?", score.score).count
        outscored_percentage = (lower_scores.to_f / total_scores)*100
        
        score.update_column(:outscored_percentage, outscored_percentage)
        score.update_column(:team_win, team_win?)
      elsif league.uses_groups?
        score.update_column(:points, score.points_awarded)
      end
        
    end
  end

  def team
    teams = Team.where(league_night: league_game.league_night)
    tps = TeamPlayer.where(team_id: teams).where(player_id: player_id)
    tps.first.team unless tps.empty?
  end

  def team_win?
    team.total_score(league_game) > team.opponent.total_score(league_game) if team
  end
end
