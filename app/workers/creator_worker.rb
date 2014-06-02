class CreatorWorker
  include Sidekiq::Worker
  
  def self.create_creators(parsed_response)
    puts "Creating Creators"
    parsed_response.each do |cr|
      puts "Writer: #{cr['writ']}"
      puts "Artist: #{cr['artst']}"

      encoded_writer = cr['writ']
      encoded_artist = cr['artst']

      writer = Creator.where(name: encoded_writer, role: 'writer').first_or_create
      artist = Creator.where(name: encoded_artist, role: 'artist').first_or_create
    end

    ComicSeriesWorker.create_series(parsed_response)
  end
end
