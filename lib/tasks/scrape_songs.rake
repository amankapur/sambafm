task :scrape_songs => :environment do 
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  require 'soundcloud'


  url = "http://www.goodmusicallday.com/feed/"
  @doc = Nokogiri::XML(open(url))

  SCRAPED_IDS = []
  @doc.xpath("//content:encoded").each do |link|
    r = /tracks%2F(\d)*/
    if link.text.include?("w.soundcloud")
      a= r.match link
      if a != nil
        a = a.to_s
        a = a[9..17]
      end 
        SCRAPED_IDS << a
    end
  end
  client_id =  '8d4242fa1237419ca04ec11eb51007c0'
  client = Soundcloud.new(:client_id => client_id)

  SONG_HASH  = Hash.new()
  
  counter = 0
  SCRAPED_IDS.each do |id|

    if id!= nil && Song.find(:first, conditions: {songid: id}) == nil
      puts 'adding to hash    ' + id
      begin
        arr_temp= []
        track = client.get('/tracks/' + id)
        arr_temp << track.title
        arr_temp << track.stream_url
        SONG_HASH[id] = arr_temp
      rescue 
        "ResponseError"
        puts " ERROR in getting song     " + id
      end
    end

  end
  scraped_songs = SONG_HASH
  scraped_songs.keys.each do |soundcloud_id|
    if scraped_songs[soundcloud_id] != nil           # if there is a strem url and title

      streamUrl = scraped_songs[soundcloud_id][1] + "?client_id=" + client_id
      
      Song.create(:artist => 'Mr. Bojangles',
                  :songid => soundcloud_id,
                  :title => scraped_songs[soundcloud_id][0],
                  :stream_url =>streamUrl)
      puts 'creating song in db        ' + soundcloud_id
    end
  end
end
