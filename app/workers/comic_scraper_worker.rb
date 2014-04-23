class ComicScraperWorker
  include Sidekiq::Worker

  def perform
    today = Date.today
    next_wednesday = 1.week.from_now
    ComicScraper.new(today, next_wednesday).scrape_release_dates
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
# def wednesday_pull
#   puts 'hi'
# end
