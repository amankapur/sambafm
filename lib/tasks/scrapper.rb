require './lib/tasks/songtemp'
#require './songtemp'

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'soundcloud'

class Scrapper

  def initialize(url_hash)
    ###
    # url_hash contains all blogs RSS feed urls, and values
    # as what type of hosting does that blog have such as 
    # soundcloud or sharebeast etc...
    ###

    @urls = url_hash
    @songs = get_songs(url_hash)
  end

  def songs
    @songs
  end

  def urls
    @urls
  end

  def get_songs(url_hash)
    songs = []
    puts url_hash
    url_hash.each_pair do |url, host_arr|
      puts url
      host_arr.each do |host|
        puts host
        if host == "Soundcloud"
          a = scrape_soundcloud(url)
          puts "number of SC songs     " + a.count.to_s
          a.each do |song|
            songs << song
          end
        else
        if host == "Sharebeast"
          a = scrape_sharebeast(url)
          puts "number of ShareBeast songs     " + a.count.to_s
          a.each do |song|
            songs << song
            #puts " sharebeast song added with id   " + song.uid.to_s
          end
        end
      end
        #### INSERT OTHER HOSTING SERVICES HERE ####

      end

      ## end of GMAD ##
    end
    puts 'total scraped songs  ' + songs.count.to_s
    return songs
  end

  def scrape_soundcloud(url)
    client_id =  '8d4242fa1237419ca04ec11eb51007c0'
    client = Soundcloud.new(:client_id => client_id)
    sc_songs = []

    @doc = Nokogiri::XML(open(url))

    @doc.xpath("//content:encoded").each do |string|
      id = get_soundcloudid(string)
      if id != nil #and Song.find(:all, :conditions => {:songid => id}) == nil 
        begin 
          track = client.get('/tracks/' + id)
        rescue
          puts "could not get Souncloud song  " + id.to_s
          track = nil
        end

        if track !=nil
          title = track.title
          
          artist = get_artist(title)
          
          r = /-(.*)/
          b = title.match r
          if b!= nil
            title = b[1]
          end

          source = get_source(url)
          stream_url = track.stream_url
          song = Songtemp.new(id, title, artist, source, stream_url)
          sc_songs << song
        end
      end
    end
    return sc_songs
  end

  def get_artist(title)
    r = /(.*)?-/
    #puts title
    if title == nil
      return "Unknown"
    end
    b = title.match r
    if b != nil
      return b[1]
    end
    return "Unknown"
  end
  def get_soundcloudid(string)
    r = /tracks%2F(\d)*/
    a= r.match string
    if a != nil
      a = a.to_s
      a = a[9..17]
    end
    return a
  end

  def scrape_sharebeast(url)

    sc_songs = []
    @doc = Nokogiri::XML(open(url))
    @doc.xpath("//content:encoded").each do |string|
      if string.to_s.include?("sharebeast") 
        id = get_sharebeastid(string)
        if id != nil #and Song.find(:all, :conditions => {:songid => id}) == nil

          source = get_source(url)
          title = get_sharebeasttitle("http://www.sharebeast.com/" + id)
          
          artist = get_artist(title)
          
          r = /-(.*)/
          b = title.match r
          if b!= nil
            title = b[1]
          end

          stream_url = "http://www.sharebeast.com/mp3embed-" + id + ".mp3"
          song = Songtemp.new(id, title, artist, source, stream_url)
          sc_songs << song
        end
      end
    end
    return sc_songs
  end

  def get_sharebeasttitle(url)
    a = ""
    @doc = Nokogiri::HTML(open(url))
    @doc.xpath("//title").each do |string|
      a += string.text[0..-5]
    end
    return a
  end
  def get_sharebeastid(input)
    if input == nil
      return nil
    end
    r = /(file=)(.*?)(&)/
    temp = input.to_s
    a = temp.match r
    if a == nil
      return a
    end
    if a[2]!=nil
      return a[2]
    end
    return nil
  end

  def get_source(url)
    if url.include?("goodmusicallday")
      return "Good Music All Day"
    end
    if url.include?("nah_right")
      return "Nah Right"
    end
    return "Unknown"
  end

  #end class
end
