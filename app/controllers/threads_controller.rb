class ThreadsController < ApplicationController
  def index
    @topic = Topic.find(params[:topic_id])
    @threads = @topic.subjects
  end
end