class Subject < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  has_many :posts

  is_impressionable

  validates_presence_of :user_id, :topic_id, :title, :body

  def recent_post_user
    if posts.empty?
      user
    else
      posts.last.user
    end
  end
end