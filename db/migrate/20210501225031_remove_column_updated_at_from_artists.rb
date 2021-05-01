class RemoveColumnUpdatedAtFromArtists < ActiveRecord::Migration[5.2]
  def change
    remove_column :artists, :updated_at, :datetime
  end
end
