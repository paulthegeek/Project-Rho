class AddArchivedToPublishers < ActiveRecord::Migration
  def change
    add_column :publishers, :archived, :boolean, default: false

    Publisher.update_all({
      archived: false
    })
  end
end
