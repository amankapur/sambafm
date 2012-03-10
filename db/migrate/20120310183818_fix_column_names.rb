class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :relationships, :liker, :liker_id
    rename_column :relationships, :song_liked, :liked_song_id
  end
end
