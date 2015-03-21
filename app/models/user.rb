class User < ActiveRecord::Base
  validates_presence_of :username
  validates_uniqueness_of :username
  validates :password, length: {minimum: 5}

  has_many :subjects
  
  has_secure_password
end