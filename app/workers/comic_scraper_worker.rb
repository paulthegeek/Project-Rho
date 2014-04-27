class ComicScraperWorker
  include Sidekiq::Worker

  def perform
    today = Date.today
    next_wednesday = 1.week.from_now
    ComicScraper.new(today, next_wednesday).scrape_release_dates
  end
end
