json.array!(@leagues) do |league|
  json.extract! league, :id, :start_date, :title
  json.url league_url(league, format: :json)
end
