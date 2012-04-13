require './scrapper'

hash = {"http://www.goodmusicallday.com/feed" => ["Soundcloud", "Sharebeast"]}

a = Scrapper.new(hash)

puts "Songs scrapped = " + a.songs.count.to_s

