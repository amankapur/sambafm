class PlaylistsController < ApplicationController

  def show
    @playlist = Playlist.find(params[:id])
    @songs = @playlist.playlist_items.collect { |item| item.song }
  end

  def create
    @playlist = current_user.create_playlist! params[:playlist][:name]

    respond_to do |format|
      format.html { redirect_to @playlist }
      format.js
    end
  end

end
