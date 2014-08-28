class AddArchivedToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :archived, :boolean, default: false

    Creator.update_all({
      archived: false
    })
  end
end
