total_scores = score.league_game.scores.where("id <> ?", score.id).count
lower_scores = score.league_game.scores.where("score < ?", score.score).count
win_precent << lower_scores.to_f / total_scores

win_percent = []
player = Player.find(2)

Player.all.each do |player|
win_percent = []
Score.where(player_id: player.id).each do |score|
total_scores = score.league_game.scores.where("id <> ?", score.id).count
lower_scores = score.league_game.scores.where("score < ?", score.score).count
win_percent << lower_scores.to_f / total_scores
end;false
puts "#{player.name}: #{(win_percent.inject{ |sum, el| sum + el }.to_f / win_percent.size).round(4) * 100}"
end;false