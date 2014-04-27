class ComicScraper

  def initialize(today, next_wednesday)
    @today = today
    @next_wed = next_wednesday
  end

  def scrape_release_dates
    uri = 'http://www.midtowncomics.com/store/ajax_wr_online.asp?cat=61&wdate='
    puts 'Sending request.....'
    response = HTTParty.post(uri + '4/23/2014')
    parsed_response = eval response
    parsed_response.each do |comic|
      @comic = Comic.new({title: comic[:pr_ttle], price: comic[:pr_price]})
      @comic.save
    end
  end
end


# Get the date for the following Wednesday
# Make two calls to the endpoint using this Wednesday and the following Wednesday
# To get comic cover images you will need to use the value from the pr_parentid key and input into this url - http://www.midtowncomics.com/images/PRODUCT/FUL/1327410_ful.jpg
# Store comic information in database and images in S3 store

# uri = 'http://www.midtowncomics.com/store/ajax_wr_online.asp?cat=61&wdate=4/23/2014'
# response = HTTParty.post(uri)
# puts response
#
