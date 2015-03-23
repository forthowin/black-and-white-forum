class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  self.per_page = 10

  validates_presence_of :body, :user_id, :subject_id
end