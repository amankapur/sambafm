class BlogFollowing < ActiveRecord::Base
  attr_accessible :blog_id
  belongs_to :blog, class_name: "Blog"
  belongs_to :user, class_name: "User"
  validates :blog_id, presence: true
  validates :user_id, presence: true
end
# == Schema Information
#
# Table name: blog_followings
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  blog_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

