class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  validates_presence_of :user_id, :topic_id, :title, :body
end