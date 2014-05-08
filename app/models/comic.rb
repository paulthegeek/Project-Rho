class Comic < ActiveRecord::Base
  validates :title, presence: true
  validates :price, presence: true
  validates :image_id, presence: true
  validates :comic_series_id, presence: true
  validates :publisher_id, presence: true
  validates :release_date, presence: true

  belongs_to :comic_series
  has_and_belongs_to_many :creators
end
