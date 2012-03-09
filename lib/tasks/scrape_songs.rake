task :scrape_songs => :environment do 
    scraped_songs = SONG_HASH

    scraped_songs.keys.each do |soundcloud_id|
      if scraped_songs[soundcloud_id] != nil

        Song.create(:songid => soundcloud_id,
                    :title => scraped_songs[soundcloud_id][0],
                    :description => scraped_songs[soundcloud_id][1])
      end
    end

    
end
