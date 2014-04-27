class Creator < ActiveRecord::Base
  validates :name, presence: true
  validates :role, presence: true

  has_and_belongs_to_many :comics
end
