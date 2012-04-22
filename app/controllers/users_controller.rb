class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def library
    @user = User.find(params[:id])
    @songs = @user.liked_songs

    respond_to do |format|
      format.js { render layout: false }
      format.html
    end
  end

  def stream
    @user = User.find(params[:id])
    @songs = @user.followed_blogs.collect{|blog| blog.songs}.flatten(1)

    respond_to do |format|
      format.js { render layout: false }
      format.html
    end
  end

  def playlists
    @user = User.find(params[:id])
    @playlists = @user.playlists

    respond_to do |format|
      format.js {render layout: false }
      format.html
    end
  end

  def blogs
    @user = User.find(params[:id])
    @blogs = @user.followed_blogs
  end
end
