# == Schema Information
#
# Table name: relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Relationship < ActiveRecord::Base
  # unlike the default generate Relationship model, in this case only the followed_id is accessible.
  # Not sure what the logic on this is.
  attr_accessible :followed_id

  # Rails would infer a name like :follower_id and :followed_id, but since there is neither a Followed or a Follower model
  # we need to supply the class name User
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :followed_id, presence: true
  validates :follower_id, presence: true
end
