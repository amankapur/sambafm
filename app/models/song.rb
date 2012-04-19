class Song < ActiveRecord::Base
  attr_accessible :title, :artist, :length, :id, :songid, :stream_url, :blog, :source

  has_many :song_relationships, foreign_key: "liked_song_id", dependent: :destroy
  has_many :likers, through: :song_relationships

  belongs_to :blog
  validates :title, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :artist, presence: true
  validates :blog, presence: true
end
# == Schema Information
#
# Table name: songs
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  artist      :string(255)
#  source      :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  songid      :integer
#  description :string(255)
#  stream_url  :string(255)
#  blog_id     :integer
#

