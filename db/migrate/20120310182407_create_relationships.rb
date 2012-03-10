class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :liker
      t.integer :song_liked

      t.timestamps
    end

    add_index :relationships, :song_liked
    add_index :relationships, :liker
    add_index :relationships, [:song_liked, :liker], unique: true
  end
end
