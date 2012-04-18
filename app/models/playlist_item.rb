class PlaylistItem < ActiveRecord::Base
  attr_accessible :song_id, :index
  belongs_to :playlist
  belongs_to :song
  validates :song_id, presence: true
  validates :playlist_id, presence: true
  validates :index, presence: true
end
# == Schema Information
#
# Table name: playlist_items
#
#  id          :integer         not null, primary key
#  playlist_id :integer
#  song_id     :integer
#  index       :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

