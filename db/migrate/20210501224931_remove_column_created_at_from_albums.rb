class RemoveColumnCreatedAtFromAlbums < ActiveRecord::Migration[5.2]
  def change
    remove_column :albums, :created_at, :datetime
  end
end
