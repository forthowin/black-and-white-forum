class UsersController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]
  before_action :require_user, only: :show

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

  def show
    @user = User.find params[:id]
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end