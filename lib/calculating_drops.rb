league = League.find(1)

Player.all.each do |player|
player_scores = []
league.league_nights.each do |league_night|
	player_scores << player.points(league_night)
end
player_scores = player_scores.compact.reject{|s| s == 0}
if player_scores.length >= 7
	player_scores.sort!{|a,b| a <=> b}
	player_scores.slice!(0)
end
puts "#{player.nickname}: #{(player_scores.inject{ |sum, el| sum + el }.to_f / player_scores.size / 5.to_f).round(3)}"
end