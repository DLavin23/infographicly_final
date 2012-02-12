class User < ActiveRecord::Base
  has_many :articles
  
  validates :user_name, :uniqueness => true
end
