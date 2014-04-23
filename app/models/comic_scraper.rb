class ComicScraper

  def initialize
    @today = today
    @next_wed = next_wednesday
  end

  def scrape_release_dates
    puts "I'm running some shit"
    print @today + ', ' + @next_wed
  end
end
