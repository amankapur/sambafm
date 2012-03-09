class SoundcloudaddsongsDescription < ActiveRecord::Migration
   def change
    change_table :songs do |t|
      t.string :description

    end
  end

end
