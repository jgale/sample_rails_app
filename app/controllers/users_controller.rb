class UsersController < ApplicationController
  def new # GET page to make a new user (signup)
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create # POST create a new user
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"
      # Note that we can omit the user_path in the redirect, writing simply redirect_to @user to redirect to the user show page.
      # Why??
      redirect_to @user
    else
      render 'new'
    end
  end
end