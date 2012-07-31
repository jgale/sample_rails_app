# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Micropost < ActiveRecord::Base
  attr_accessible :content # don't want user_id to be accessible
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user) #class method
  	# Prelim: All of our stuff: Micropost.where("user_id = ?", id)
  	# Now we want something more like: where("user_id in (?) OR user_id = ?", following_ids, user)
  	# But you just pass 'user' as a Rails convention, it will use the ID automatically
  	# To get the IDs, we might do something like this:
  	#   user.followed_users.map(&:id)
  	# Because this is so common, Rails lets you just use:
  	#   user.followed_users_ids
  	# We would join them into a string for SQL, but rails does this for us with the ? interpolation,
  	# and makes it more database independent

  	followed_user_ids = user.followed_user_ids
    where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  end
end
