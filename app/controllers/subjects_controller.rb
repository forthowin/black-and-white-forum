class SubjectsController < ApplicationController
  before_action :require_user

  def index
    @topic = Topic.find(params[:topic_id])
    @subjects = Subject.includes(:posts).order("posts.created_at DESC").where("topic_id = ?", @topic.id)
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
    begin
      create_subject_and_post
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "Title and body cannot be blank."
      redirect_to :back
    end
  end

  private

  def create_subject_and_post
    ActiveRecord::Base.transaction do
      subject = Subject.new(title: params[:title], topic_id: params[:topic_id], user: current_user)
      if subject.save!
        Post.create!(body: params[:body], subject_id: subject.id, user: current_user)
        flash[:success] = "Subject has been created."
        redirect_to forum_subject_path(params[:topic_id], subject.id)
      end
    end
  end
end