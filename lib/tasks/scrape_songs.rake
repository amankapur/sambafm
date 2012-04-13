task :scrape_songs => :environment do 

  require './lib/tasks/scrapper'
  hash = {"http://www.goodmusicallday.com/feed" => ["Soundcloud", "Sharebeast"]}
  a = Scrapper.new(hash)
  a.songs.each do |song|
    Song.create(
      :artist => "Mr.Hobo",
      :songid => song.uid,
      :title => song.title,
      :stream_url => song.stream_url
      )
    puts "song created with songid" + song.uid
  end

end
