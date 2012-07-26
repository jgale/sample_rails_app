# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  # Very magical. 
  # Next, we need an authenticate method to compare an encrypted password to the password_digest
  # to authenticate users. This is the only nontrivial step, and in the latest version of Rails all
  # these features come for free with one method, has_secure_password.
  # As long as there is a password_digest column in the database,
  # adding this one method to our model gives us a secure way to create and authenticate new users.
  # (If has_secure_password seems a bit too magical for your taste, I suggest taking a look at the
  # source code for secure_password.rb. https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  has_secure_password

  before_save { |user| user.email = email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # One big problem with uniqueness - it's not unique! Can be racy. Needs
  # to be unique at the database level. http://ruby.railstutorial.org/chapters/modeling-users#sec:uniqueness_validation
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


end
