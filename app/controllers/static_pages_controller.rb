class StaticPagesController < ApplicationController
  def front
    redirect_to topics_path if logged_in?
  end
end