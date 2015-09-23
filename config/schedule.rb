# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

job_type :runner, %Q{export PATH=/Users/X-Wing/.rbenv/shims:/Users/X-Wing/src/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && bundle exec rails runner -e development ':task' :output }

set :output, "/Users/X-Wing/Desktop/cron_log.log"

# every :wednesday, at: '2:00am' do
#   runner 'ComicScraperWorker.perform_async', environment: 'development'
# end

every 1.hour do
  runner 'ComicScraperWorker.perform_async', environment: 'development'
end
