require './scrapper'

hash = {"http://www.goodmusicallday.com/feed" => ["Soundcloud", "Sharebeast"],
        "http://feeds.feedburner.com/nah_right?format=xml" => ["Sharebeast"]}

a = Scrapper.new(hash)

puts "Songs scrapped = " + a.songs.count.to_s

