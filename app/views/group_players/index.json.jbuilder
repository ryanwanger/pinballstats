json.array!(@group_players) do |group_player|
  json.extract! group_player, :id, :group, :player_id
  json.url group_player_url(group_player, format: :json)
end
