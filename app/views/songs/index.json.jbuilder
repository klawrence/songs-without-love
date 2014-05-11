json.array!(@songs) do |song|
  json.extract! song, :id, :artist, :title, :cached_slug, :lyrics, :peak_chart_position, :weeks_on_chart, :first_charted_on
  json.url song_url(song, format: :json)
end
