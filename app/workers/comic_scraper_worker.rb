require 'open-uri'
require 'pry'

class ComicScraperWorker
  include Sidekiq::Worker

  def perform
    comic_day = Chronic.parse('next wednesday').strftime('%-m/%d/%Y')
    scrape_release_dates(comic_day)
  end

  def scrape_release_dates(comic_day)
    puts 'Let\'s get these comics...'

    uri = "http://www.midtowncomics.com/store/ajax_wr_online.asp?cat=61&wdate=#{comic_day}"
    response = HTTParty.post(uri)
    response = response.parsed_response
    ComicScraperWorker.data_cleanup(response)
  end

  def self.data_cleanup(response)
    response.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')

    #Grab every key in the data object and put quotes around it
    response = response.gsub(/\s*(\w+):\s*"/, '"\1": "')
    #Remove the comma before the end of the JSON object
    response = response.gsub(/(,)}/, "}")
    # Remove the comma before closing bracket of the array
    response = response.gsub(/(,)]/, "]")

    response = JSON.parse(response)
    PublisherWorker.create_publishers(response)
  end
end
