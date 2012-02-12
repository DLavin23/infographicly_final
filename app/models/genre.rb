class Genre < ActiveRecord::Base
  has_many :sources
  has_many :articles, :through => :sources
end
