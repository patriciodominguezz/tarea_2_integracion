class RemoveColumnCreatedAtFromArtists < ActiveRecord::Migration[5.2]
  def change
    remove_column :artists, :created_at, :datetime
  end
end
