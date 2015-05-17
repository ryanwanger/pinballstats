json.array!(@matchups) do |matchup|
  json.extract! matchup, :id, :league_night_id
  json.url matchup_url(matchup, format: :json)
end
