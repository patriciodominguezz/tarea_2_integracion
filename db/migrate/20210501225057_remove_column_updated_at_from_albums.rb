class RemoveColumnUpdatedAtFromAlbums < ActiveRecord::Migration[5.2]
  def change
    remove_column :albums, :updated_at, :datetime
  end
end
