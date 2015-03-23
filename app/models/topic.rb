class Topic < ActiveRecord::Base
  validates_presence_of :title, :description

  has_many :subjects, -> { order("created_at DESC") }
end