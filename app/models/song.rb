class Song < ActiveRecord::Base
  attr_accessible :title, :artist, :length, :id, :songid, :stream_url

  validates :title, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :artist, presence: true
  has_many :song_relationships, foreign_key: "liked_song_id", dependent: :destroy
  has_many :likers, through: :song_relationships
  
  belongs_to :blog
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
#

