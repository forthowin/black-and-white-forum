class Subject < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  has_many :posts

  is_impressionable

  self.per_page = 10

  validates_presence_of :user_id, :topic_id, :title
end