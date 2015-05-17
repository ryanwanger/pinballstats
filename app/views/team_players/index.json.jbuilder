json.array!(@team_players) do |team_player|
  json.extract! team_player, :id, :team_id, :player_id
  json.url team_player_url(team_player, format: :json)
end
