class ComicSeriesWorker
  def create_series(parsed_response)
    parsed_response.each do |cs|
      doc = Nokogiri::HTML(open("http://www.midtowncomics.com/store/pop_subscrip.asp?SubID=#{cs[:su_id]}"))

      if cs[:su_id] == '0'
        comic_series_name = cs[:pr_ttle]
      else
        comic_series_name = doc.css('font')[1].text
      end
      @comic_series = ComicSeries.find_or_create_by(name: comic_series_name, sub_id: cs[:su_id])
    end

    ComicWorker.create_comics(parsed_response)
  end
end
