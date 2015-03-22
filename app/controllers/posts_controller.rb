class PostsController < ApplicationController
  before_action :require_user

  def create
    post = Post.new(body: params[:body], subject_id: params[:subject_id], user_id: current_user.id)
    if post.save
      flash[:success] = "Post created."
    else
      flash[:danger] = "Your reply can't be empty."
    end
    redirect_to :back
  end
end