class SubjectsController < ApplicationController
  before_action :require_user

  def index
    @topic = Topic.find(params[:topic_id])
    @subjects = Subject.where("topic_id = ?", @topic.id).includes(:post).order("posts.created_at DESC")
    #@topic.subjects.includes(:posts).order("posts.created_at DESC")
  end

  def show
    @topic = Topic.find params[:topic_id]
    @subject = Subject.find params[:subject_id]
    @posts = @subject.posts.paginate(:page => params[:page])
    impressionist @subject
  end

  def new
    @topic = Topic.find params[:topic_id]
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.user = current_user
    @subject.topic_id = params[:topic_id]
    if @subject.save
      post = Post.create(body: params[:subject][:body], subject_id: @subject.id, user: current_user)
      flash[:success] = "Subject has been created."
      redirect_to forum_subject_path(params[:topic_id], @subject.id)
    else
      @topic = Topic.find params[:topic_id]
      render :new
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:title, :body)
  end
end