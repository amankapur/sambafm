class AddNameToPlaylist < ActiveRecord::Migration
  def change
    add_column :playlists, :name, :string

  end
end
