require 'open-uri'

class ComicScraper

  def initialize(today, next_wednesday)
    @today = '4/23/14'
    @next_wed = '4/30/14'
  end

  def run_scraper
    puts 'Running for Wednesday.....'
    scrape_release_dates(@today)
    puts 'Running for Next Wednesday......'
    scrape_release_dates(@next_wednesday)
  end

  def scrape_release_dates(date)
    uri = 'http://www.midtowncomics.com/store/ajax_wr_online.asp?cat=61&wdate='
    puts 'Sending request.....'
    response = HTTParty.post(uri + date)
    response.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    context = V8::Context.new
    parsed_response = context.eval(response)
    create_publishers(parsed_response)
    create_creators(parsed_response)
    comic_series(parsed_response)
    create_comics(parsed_response, date)
    puts 'Done...........'
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
