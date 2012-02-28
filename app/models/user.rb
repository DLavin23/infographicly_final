class User < ActiveRecord::Base
  has_many :articles
  
  # is has_secure_password the same as below...?
  
  validates :user_name, :uniqueness => true
end
