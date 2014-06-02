class ComicSeriesWorker
  include Sidekiq::Worker
  
  def self.create_series(parsed_response)
    puts "Creating Series..."
    parsed_response.each do |cs|

      puts "Comic Series: #{cs['pr_ttle']}"
      doc = Nokogiri::HTML(open("http://www.midtowncomics.com/store/pop_subscrip.asp?SubID=#{cs['su_id']}"))

      if cs['su_id'] == '0'
        comic_series_name = cs['pr_ttle']
      else
        comic_series_name = doc.css('font')[1].text
      end
      
      ComicSeries.where(name: comic_series_name, sub_id: cs['su_id']).first_or_create
    end

    ComicWorker.create_comics(parsed_response, Date.today.to_s)
  end
end
