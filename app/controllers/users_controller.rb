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
      sign_in @user
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"
      # Note that we can omit the user_path in the redirect, writing simply redirect_to @user to redirect to the user show page.
      # Why?? I think Ruby is just clever like that.
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
end