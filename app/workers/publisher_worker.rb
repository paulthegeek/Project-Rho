class PublisherWorker
  def self.create_publishers(parsed_response)
    puts 'Creating Publishers...'
    parsed_response.each do |pub|
      puts "Publisher: #{pub['mn_name']}"
      Publisher.find_or_create_by(name: pub['mn_name'])
    end

    CreatorWorker.create_creators(parsed_response)
  end
end
