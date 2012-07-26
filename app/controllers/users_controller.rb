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
    else
      render 'new'
    end
  end
end