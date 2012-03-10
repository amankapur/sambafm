class SongRelationship < ActiveRecord::Base
  attr_accessible :liked_song_id#, :liker
  belongs_to :liked_song, class_name: "Song"
  belongs_to :liker, class_name: "User"
  validates :liked_song_id, presence: true
  validates :liker_id, presence: true
end
# == Schema Information
#
# Table name: relationships
#
#  id            :integer         not null, primary key
#  liker_id      :integer
#  liked_song_id :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

