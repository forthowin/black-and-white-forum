class ThreadsController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @topic = Topic.find(params[:topic_id])
    @threads = @topic.subjects
  end

  def show
    @topic = Topic.find params[:topic_id]
    @thread = Subject.find params[:thread_id]
    @post = Post.new
  end

  def new
    @topic = Topic.find params[:topic_id]
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.user = current_user
    @subject.topic_id = params[:topic_id]
    @subject.save
    flash[:success] = "Subject has been created."
    redirect_to forum_thread_path(params[:topic_id], @subject.id)
  end

  private

  def subject_params
    params.require(:subject).permit(:title, :body)
  end
end