module SessionsHelper

  def sign_in(user) 
  	# Can use cookies like a hash... cookies[:remember_token] = { value:   user.remember_token, expires: 20.years.from_now.utc }
  	# This pattern of setting a cookie that expires 20 years in the future became so common that Rails added a
  	# special permanent method to implement it, so that we can simply write
    cookies.permanent[:remember_token] = user.remember_token

    #The purpose of this line is to create current_user, accessible in both controllers and views, which will allow constructions such as
    # <%= current_user.name %>
    # Need self, or else it would just create a local variable named current_user
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
  	# @current_user     # Useless! Don't use this line.
  	# I don't really get this.... i guess it means it would have no persistence at all
  	# The problem is that it utterly fails to solve our problem: with the code in Listing 8.21, the user’s signin
  	# status would be forgotten: as soon as the user went to another page—poof!—the session would
    # end and the user would be automatically signed out. 

    # ||= only sets if it is undefined
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
  	self.current_user = nil
  	cookies.delete(:remember_token)
  end
end