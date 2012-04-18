class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  has_many :song_relationships, foreign_key: "liker_id", dependent: :destroy
  has_many :liked_songs, through: :song_relationships

  has_many :blog_followings, foreign_key: "user_id", dependent: :destroy
  has_many :followed_blogs, through: :blog_followings, source: :blog

  has_many :playlists

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def likes_song?(song)
    self.song_relationships.find_by_liked_song_id(song.id)
  end

  def like_song!(song)
    self.song_relationships.create!(liked_song_id: song.id)
  end

  def unlike_song!(song)
    self.song_relationships.find_by_liked_song_id(song.id).destroy
  end

  def follows_blog?(blog)
    self.blog_followings.find_by_blog_id(blog.id)
  end

  def follow_blog!(blog)
    self.blog_followings.create!(blog_id: blog.id)
  end

  def unfollow_blog!(blog)
    self.blog_followings.find_by_blog_id(blog.id).destroy
  end

end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

