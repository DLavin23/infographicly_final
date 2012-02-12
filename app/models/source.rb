class Source < ActiveRecord::Base
  belongs_to :genre
  has_many :articles
end
