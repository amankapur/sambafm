class CreateBlogFollowings < ActiveRecord::Migration
  def change
    create_table :blog_followings do |t|
      t.integer :user_id
      t.integer :blog_id

      t.timestamps
    end

    add_index :blog_followings, :user_id
    add_index :blog_followings, :blog_id
    add_index :blog_followings, [:user_id, :blog_id], unique: true
  end
end
