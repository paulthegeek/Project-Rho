class AddFiltersToComics < ActiveRecord::Migration
  def change
    add_column :comics, :variant, :boolean
    add_column :comics, :reprint, :boolean
  end
end
