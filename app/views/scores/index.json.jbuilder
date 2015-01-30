json.array!(@scores) do |score|
  json.extract! score, :id, :score, :player_id, :game_id, :group_id
  json.url score_url(score, format: :json)
end
