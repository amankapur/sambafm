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
     SCRAPED_IDS << a
   end 
  end
end


client = Soundcloud.new(:client_id => 'e17759e5c8406ad73b8b1a38504f17b3')

SONG_HASH  = Hash.new()


counter = 0

SCRAPED_IDS.each do |id|
  begin
    
    arr_temp = []
    track = client.get('/tracks/' + id)
    arr_temp << track.title
    arr_temp << track.stream_url
    SONG_HASH[id] = arr_temp
  rescue 
    "ResponseError"
  end

end

