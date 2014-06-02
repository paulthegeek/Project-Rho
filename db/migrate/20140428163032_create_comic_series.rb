class CreateComicSeries < ActiveRecord::Migration
  def change
    create_table :comic_series do |t|
      t.string :name
      t.integer :sub_id
    end
  end
end
