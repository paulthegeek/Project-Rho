class Publisher < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :comics

  def create_publishers(parsed_response)
    parsed_response.each do |pub|
      @publisher = Publisher.where(name: pub[:mn_name].to_s).first_or_create
    end
  end

  def self.find_unarchived(id)
    find_by!(id: id, archived: false)
  end

  def archive
    self.archived = true
    self.save
  end
end
