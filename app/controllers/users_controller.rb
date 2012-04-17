class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def library
    @user = User.find(params[:id])
    @songs = @user.liked_songs
  end

  def stream
    @user = User.find(params[:id])
    @songs = @user.followed_blogs.collect{|blog| blog.songs}.flatten(1)
  end
end
