class Creator < ActiveRecord::Base
  validates :name, presence: true
  validates :role, presence: true

  has_and_belongs_to_many :comics

  def create_creators(parsed_response)
    parsed_response.each do |cr|
      encoded_writer = cr[:writ]
      encoded_artist = cr[:artst]

      @writer = Creator.find_or_create_by(name: encoded_writer, role: 'writer')
      @artist = Creator.find_or_create_by(name: encoded_artist, role: 'artist')
    end
  end

  def archive
    self.archived = true
    self.save
  end
end
