class Relationship < ActiveRecord::Base
end
# == Schema Information
#
# Table name: relationships
#
#  id         :integer         not null, primary key
#  liker      :integer
#  song_liked :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

