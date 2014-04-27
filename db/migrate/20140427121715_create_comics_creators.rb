class CreateComicsCreators < ActiveRecord::Migration
  def change
    create_table :comics_creators, id: false do |t|
      t.belongs_to :comic
      t.belongs_to :creator
    end
  end
end
