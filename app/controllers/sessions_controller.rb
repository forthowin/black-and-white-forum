class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: :new

  def new
    @user = User.new
  end

  def create
    user = User.find_by username: params[:username]
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully signed in."
      redirect_to forum_path
    else
      flash[:danger] = "Invalid username or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully log out."
    redirect_to root_path
  end
end