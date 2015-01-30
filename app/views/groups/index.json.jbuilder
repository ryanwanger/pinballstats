json.array!(@groups) do |group|
  json.extract! group, :id, :league_night_id, :group_rank
  json.url group_url(group, format: :json)
end
