class BlogFollowingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @blog = Blog.find(params[:blog_following][:blog_id])
    current_user.follow_blog!(@blog)
    respond_to do |format|
      format.html { redirect_to @blog }
      format.js
    end
  end

  def destroy
    @relationship = BlogFollowing.find(params[:id])
    @blog = @relationship.blog
    current_user.unfollow_blog!(@blog)
    @blogs = current_user.followed_blogs
    @songs = @blogs.collect {|blog| blog.songs}.flatten(1)
    respond_to do |format|
      format.html { redirect_to @blog }
      format.js
    end
  end
end
