class Addsoundcloudidtosongs < ActiveRecord::Migration
  def change
    change_table :songs do |t|
      t.integer :songid

    end
  end
end
