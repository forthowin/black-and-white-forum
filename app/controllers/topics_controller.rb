class TopicsController < ApplicationController
  before_action :require_user
  
  def index
    @topics = Topic.all
  end
end