task :scrape_songs => :environment do
  require './lib/tasks/scrapper'


  hash =
  {
  "http://www.goodmusicallday.com/feed" =>
           ["Soundcloud", "Sharebeast"],
  "http://feeds.feedburner.com/nah_right?format=xml" =>
           ["Sharebeast"],
  "http://thissongissick.com/blog/feed/" =>
           ["Soundcloud"],
  "http://www.biggreenbeats.com/feed" =>
           ["Soundcloud"],
  "http://feeds.feedburner.com/VacayWave?format=xml" =>
           ["Soundcloud"]
  
  }

  a = Scrapper.new(hash)
  puts "scrapped songs    " + a.songs.count.to_s
  curr_count = Song.count
  a.songs.each do |song|
    if Song.find(:first, :conditions => {:songid => song.uid}) == nil
      #puts "creating song with id       " + song.uid
      #puts song.artist
      #puts song.title
      #puts song.source
      
      #puts song.stream_url

      Song.create(
        :artist => song.artist,
        :songid => song.uid,
        :title => song.title,
        :source => song.source,
        :stream_url => song.stream_url,
        :blog => Blog.find(:first, :conditions => {:name => song.source}))
       #puts "song created with songid    " + song.uid
    end
  end
  created_songs = Song.count - curr_count
  puts "Songs created   " + created_songs.to_s
end
