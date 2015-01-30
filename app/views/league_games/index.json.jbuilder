json.array!(@league_games) do |league_game|
  json.extract! league_game, :id
  json.url league_game_url(league_game, format: :json)
end
