class AddArchivedToComics < ActiveRecord::Migration
  def change
    add_column :comics, :archived, :boolean, default: false

    Comic.update_all({
      archived: false
    })
  end
end
