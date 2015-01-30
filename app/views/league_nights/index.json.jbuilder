json.array!(@league_nights) do |league_night|
  json.extract! league_night, :id, :date, :league_id, :location_id
  json.url league_night_url(league_night, format: :json)
end
