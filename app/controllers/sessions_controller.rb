class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  	  # Sign in the user and redrect to their show page
  	  sign_in user
  	  redirect_to user
  	else
  	  # Create an error message and re-render the signing form
  	  # 'render'  doesn't count as a request, flash error will stick around for too long,
  	  # so we use flash.now
  	  flash.now[:error] = 'Invalid email/password combination'
  	  render 'new' 
  	end
  end

  def destroy
  end
end
