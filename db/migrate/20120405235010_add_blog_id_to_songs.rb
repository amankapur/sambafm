class AddBlogIdToSongs < ActiveRecord::Migration
  def change
    change_table :songs do |t|
     t.integer :blog_id
    end
  end
end
