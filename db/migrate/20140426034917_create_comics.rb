class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title
      t.decimal :price
      t.integer :image_id
      t.integer :comic_series_id
      t.integer :publisher_id
      t.date :release_date

      t.timestamps
    end
  end
end
