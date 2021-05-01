class RemoveColumnCreatedAtFromTracks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tracks, :created_at, :datetime
  end
end
