require 'open-uri'
require 'pry'

class ComicScraperWorker
  include Sidekiq::Worker

  def perform
    today = Date.today.to_s
    # next_wednesday = 1.week.from_now.to_s
    scrape_release_dates(today)
    # scrape_release_dates(next_wednesday)
  end

  def scrape_release_dates(date)
    puts 'We are starting'
    # response = <<-END_OF_STRING
    #   "[{\tpr_id:\"1333023\",\tpr_ttle:\"Aron Warners Pariah Vol 2 #4\",\tcg_name:\"Comics\",\tchildcat:\"Dark Horse\",\tcg_id:\"61\",\tsu_id:\"16341\",\tmn_name:\"Dark Horse\",\tpr_lprice:\"3.39\",\tpr_price:\"3.99\",\tpr_discount:\"15\",\tpr_qty:\"8\",\tcart:\"0\",\tpr_parentid:\"1333023\",\tpr_simg:\"1\",\tsu_id:\"16341\",\tissubscribe:\"0\",\tartst:\"Brett Weldele\",\twrit:\"Aaron Warner - Phillip Gelatt\",},]"
    # END_OF_STRING

    uri = 'http://www.midtowncomics.com/store/ajax_wr_online.asp?cat=61&wdate=5/28/14'
    # response = HTTParty.post(uri + date)
    response = HTTParty.post(uri)
    response = response.parsed_response
    ComicScraperWorker.data_cleanup(response)
  end

  def self.data_cleanup(response)
    response.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
    response = response.gsub(/\s*(\w+):\s*"/, '"\1": "')
    response = response.gsub(/(,)}/, "}")
    response = response.gsub(/(,)]/, "]")
    response = JSON.parse(response)
    PublisherWorker.create_publishers(response)
  end
end
