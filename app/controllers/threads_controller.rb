class ThreadsController < ApplicationController
  def index
    @topic = Topic.find(params[:topic_id])
    @threads = @topic.subjects
  end

  def show
    @topic = Topic.find params[:topic_id]
    @thread = Subject.find params[:thread_id]
    @post = Post.new
  end
end