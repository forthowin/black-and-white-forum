class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject

  validates_presence_of :body, :user_id, :subject_id
end