class ComicWorker
  def create_comics(parsed_response, date)
    parsed_response.each do |comic|
      @creators = []
      if comic[:writ].present?
        @writer = Creator.find_by(name: comic[:writ]).id
        @creators.push(@writer)
      else
        @writer = nil
      end

      if comic[:artst].present?
        @artist = Creator.find_by(name: comic[:artst]).id
        @creators.push(@artist)
      else
        @artist = nil
      end
      # @comic_series_id = ComicSeries.find_by(sub_id: comic[:su_id]).id
      # @publisher_id = Publisher.find_by(name: comic[:mn_name]).id

      @comic = Comic.new({title: comic[:pr_ttle],
                          price: comic[:pr_price],
                          image_id: comic[:pr_id],
                          comic_series_id: ComicSeries.find_by(sub_id: comic[:su_id]).id,
                          publisher_id: Publisher.find_by(name: comic[:mn_name]).id,
                          creator_ids: @creators,
                          release_date: date })

      @comic.save
    end
  end
end