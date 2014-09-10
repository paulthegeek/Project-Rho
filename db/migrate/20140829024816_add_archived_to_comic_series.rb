class AddArchivedToComicSeries < ActiveRecord::Migration
  def change
    add_column :comic_series, :archived, :boolean, default: false

    ComicSeries.update_all({
      archived: false
    })
  end
end
