class ComicWorker
  include Sidekiq::Worker
  
  def self.create_comics(parsed_response, date)

    puts "Creating Comics"

    parsed_response.each do |comic|
      @creators = []
      if comic['writ'].present?
        @writer = Creator.find_by(name: comic['writ'])
        @creators.push(@writer)
      else
        @writer = nil
      end

      if comic['artst'].present?
        @artist = Creator.find_by(name: comic['artst'])
        @creators.push(@artist)
      else
        @artist = nil
      end
      # @comic_series_id = ComicSeries.find_by(sub_id: comic[:su_id]).id
      # @publisher_id = Publisher.find_by(name: comic[:mn_name]).id
      c = Comic.where(title: comic['pr_ttle']).first_or_create(
                  price: comic['pr_price'],
                  image_id: comic['pr_id'],
                  comic_series_id: ComicSeries.find_by(sub_id: comic['su_id']).id,
                  publisher_id: Publisher.find_by(name: comic['mn_name']).id,
                  release_date: date)

      c.creators << @creators

    end
    puts "We are finished"
  end
end
