class UsersController < ApplicationController
  before_action :logged_in_redirect

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have successfully created an account."
      redirect_to forum_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def logged_in_redirect
    if logged_in?
      flash[:danger] = "You're already logged in."
      redirect_to forum_path
    end
  end
end