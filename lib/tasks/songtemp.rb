class Songtemp

 def initialize(uid, title, artist, source, stream_url)
    @uid = uid
    @source = source
    @stream_url = stream_url
    @title = title
    @artist = artist
 end

 def uid
   @uid
 end

 def artist
   @artist
 end
 def source
   @source
 end

 def stream_url
   @stream_url
 end

 def title
   @title
 end
end
