class ComicSeries < ActiveRecord::Base
  validates :name, presence: true
  
  def self.has_no_sub_id
    ComicSeries.where('sub_id = 0' || sub_id.nil?)
  end

  def comic_series(parsed_response)
    parsed_response.each do |cs|
      doc = Nokogiri::HTML(open("http://www.midtowncomics.com/store/pop_subscrip.asp?SubID=#{cs[:su_id]}"))

      if cs[:su_id] == '0'
        comic_series_name = cs[:pr_ttle]
      else
        comic_series_name = doc.css('font')[1].text
      end
      @comic_series = ComicSeries.find_or_create_by(name: comic_series_name, sub_id: cs[:su_id])
    end
  end
  
  def archive
    self.archived = true
    self.save
  end
end
