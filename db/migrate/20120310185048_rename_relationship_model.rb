class RenameRelationshipModel < ActiveRecord::Migration
  def change
    rename_table :relationships, :song_relationships
  end
end
