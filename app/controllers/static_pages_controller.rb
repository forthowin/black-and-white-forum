class StaticPagesController < ApplicationController
  def front
    redirect_to forum_path if logged_in?
  end
end