class Subject < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  has_many :posts

  validates_presence_of :user_id, :topic_id, :title, :body
end