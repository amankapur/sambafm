class AddStreamUrlToSongs < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.string :stream_url
    end
  end
end
