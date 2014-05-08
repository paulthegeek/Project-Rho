class CreatorWorker
  def create_creators(parsed_response)
    parsed_response.each do |cr|
      encoded_writer = cr[:writ]
      encoded_artist = cr[:artst]

      @writer = Creator.find_or_create_by(name: encoded_writer, role: 'writer')
      @artist = Creator.find_or_create_by(name: encoded_artist, role: 'artist')
    end
    ComicSeriesWorker.create_series(parsed_response)
  end
end
