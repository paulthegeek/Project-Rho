class Comic < ActiveRecord::Base
  validates :title, presence: true
  validates :price, presence: true
  validates :image_id, presence: true
  validates :series_id, presence: true
  validates :publisher_id, presence: true
  validates :release_date, presence: true
end
