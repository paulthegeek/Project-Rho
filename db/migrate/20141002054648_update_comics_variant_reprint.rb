class UpdateComicsVariantReprint < ActiveRecord::Migration
  def change
    Comic.update_all({
      variant: false,
      reprint: false
    })
  end
end
