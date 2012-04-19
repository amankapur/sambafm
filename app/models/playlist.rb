class Playlist < ActiveRecord::Base
  attr_accessible :name
  validates :user_id, presence: true
  validates :name, presence: true

  belongs_to :user
  has_many :playlist_items, order: '"playlist_items"."index" ASC',
    dependent: :destroy
  has_many :songs, through: :playlist_items
end
# == Schema Information
#
# Table name: playlists
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  name       :string(255)
#

