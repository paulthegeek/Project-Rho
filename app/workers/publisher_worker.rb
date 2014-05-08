class PublisherWorker
  include Sidekiq::Worker

  def self.create_publishers(parsed_response)
    parsed_response.each do |pub|
      puts "Bout to create"
      @publisher = Publisher.where(name: pub[:mn_name].to_s).first_or_create
      CreatorWorker.create_creators(parsed_response)
    end
  end
end
