[ ![Codeship Status for paulthegeek/Project-Rho](https://www.codeship.io/projects/f8299b80-2e38-0132-d30c-4adef3b19db7/status)](https://www.codeship.io/projects/39335)

# What is Project_Rho?

I love comic books. Every Wednesday a new stack
of comics hits the physical and digital shelves. On this
day you check out what new comics are out. Some might be
from your pull list (comics you subscribe to monthly) or
there is something new you would like to try.

Currently the only way to know what new comics are coming
is to go to a comic book site and look at a long list
of books that have come out for that week. The problem I
wanted to solve was limiting that list to only the books
you care about. The list can be composed of books you read physically or digitally, regardless of where you buy them from.


# Problem
The comics industry is behind the times when it comes to technology. There is no
easy way to get data to build websites or applications around. The industry also
tends to enjoy monopolies around this data. To get around the problem I decided
to build a scraper that would fill a database of all the new comics every Wednesday.
There are a few issues that I ran into while building the scraper. The data that
is returned looks something like a json object, but it's not valid. The two main reasons are:
 1. The data that is returned has extra commas, brackets, and square brackets in the wrong places
 2. Data inconsistencies

# Solution
To get around the problem I decided to build a scraper that would fill a database
of all the new comics every Wednesday. From there endpoints were built to fuel
a front end app I would like to build one day.

# Code Tour

## Database
Postgres

## The Scraper
The scraper runs a background cron job using Sidekiq. It will fire off every Wednesday
and pull the new comic data

The ```app/workers/comic_scraper_worker.rb``` kicks the job off followed by the other four workers.

The comic_scraper_worker has a data_cleanup method that cleans up the response
using gsub. Once the data is clean we have a ruby object we can do things with.

Another intersting problem is the comic_series_worker. I needed to use Nokogiri to
pull the series title from the html page.

## MVC

The models, controllers and views deliver a crud style API that I can attach a frontend to.

## Tests
There are tests for the models, controllers, and views all using Rspec and Factory Girl

# Running The App

## Clone Git Repo
1. In your terminal window choose a directory you would like the project to live and then run this command```git clone git@github.com:paulthegeek/Project-Rho.git```

## Bundle install
Run the ```bundle install``` command

## Set the Cron job
1. If you are using Rbenv to manage your ruby versions you will need to change the job runner to point to your rbenv shims. The lines below are mine but of course the names for your computer will be different.
```
job_type :runner, %Q{export PATH=/Users/X-Wing/.rbenv/shims:/Users/X-Wing/src/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && bundle exec rails runner -e development ':task' :output }
```
1. Navigate to the project in your terminal window
2. Enter the ```whenever -w``` command into your terminal window and run it. This will set the cron job.

## Run Sidekiq
1. In your terminal window Enter the ```bundle exec sidekiq``` command and run it.
2. Watch magic happen
