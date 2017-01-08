job_type :runner, %Q{export PATH=/Users/X-Wing/.rbenv/shims:/Users/X-Wing/src/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && bundle exec rails runner -e development ':task' :output }

set :output, 'log/cron_log.log'

# Cron to run every Wednesday at 2AM
# every :wednesday, at: '2:00am' do
#   runner 'ComicScraperWorker.perform_async', environment: 'development'
# end

# Cron to run every 5 minutes
every 20.minutes do
  runner 'ComicScraperWorker.perform_async', environment: 'development'
end
