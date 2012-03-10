class SongRelationshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @song = Song.find(params[:song_relationship][:liked_song_id])
    current_user.like_song!(@song)
    respond_to do |format|
      format.html { redirect_to @song }
      format.js
    end
  end

  def destroy
    @song = SongRelationship.find(params[:id]).liked_song
    current_user.unlike_song!(@song)
    respond_to do |format|
      format.html { redirect_to @song }
      format.js
    end
  end
end
