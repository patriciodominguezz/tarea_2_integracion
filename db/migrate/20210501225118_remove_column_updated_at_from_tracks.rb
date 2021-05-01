class RemoveColumnUpdatedAtFromTracks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tracks, :updated_at, :datetime
  end
end
