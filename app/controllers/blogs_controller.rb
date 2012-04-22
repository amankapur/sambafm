class BlogsController < ApplicationController
  def index
    @blogs = Blog.all

    respond_to do |format|
      format.js { render layout: false }
      format.html
    end
  end

  def show
    @blog = Blog.find(params[:id])
    @songs = @blog.songs
  end
end
