require './lib/tasks/songtemp'

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
    url_hash.each_pair do |url, host|
      puts url
      if url == "http://www.goodmusicallday.com/feed"
        host.each do |host|
          if host == "Soundcloud"
            a = scrape_soundcloud(url)
            puts "number of SC songs     " + a.count.to_s
            a.each do |song|
              songs << song
            end
          end
          if host == "Sharebeast"
            a = scrape_sharebeast(url)
            puts "number of ShareBeast songs     " + a.count.to_s
            a.each do |song|
              songs << song
            end
          end

          #### INSERT OTHER HOSTING SERVICES HERE ####

        end
      end

      ## end of GMAD ##
    end
    return songs
  end

  def scrape_soundcloud(url)
    client_id =  '8d4242fa1237419ca04ec11eb51007c0'
    client = Soundcloud.new(:client_id => client_id)
    sc_songs = []

    @doc = Nokogiri::XML(open(url))

    @doc.xpath("//content:encoded").each do |string|
      id = get_soundcloudid(string)
      if id != nil
       begin 
        track = client.get('/tracks/' + id)
        title = track.title
        source = get_source(url)
        stream_url = track.stream_url
        song = Songtemp.new(id, title, source, stream_url)
        sc_songs << song
       rescue
        puts "could not get Souncloud song  " + id.to_s
       end
      end
    end
    return sc_songs
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

        id = get_sharebeastid(string)
        if id != nil
          source = get_source(url)
          title = get_sharebeasttitle("http://www.sharebeast.com/" + id)
          stream_url = "http://www.sharebeast.com/mp3embed-" + id + ".mp3"
          song =Songtemp.new(id, title, source, stream_url)
          sc_songs << song
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

    def get_sharebeastid(string)
      r = /(file=)(.*)(&amp;tit)/
      a = r.match string
      if a!=nil
        r2 = /=(...)*&/
        a = a.to_s
        b = r2.match a
        b = b.to_s[1..-2]
        b = b[0..11]
      end
    end

    def get_source(url)
      if url.include?("goodmusicallday")
        return "Good Music All Day"
      end
      return "Unknown"
    end

    #end class
end
