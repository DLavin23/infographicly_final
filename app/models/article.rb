require 'uri'

class Article < ActiveRecord::Base
  belongs_to :source
  belongs_to :user
  
  validates :item_num, :uniqueness => true
  
  def upcase_title
    self.title.upcase
  end
  
  
  def self.parse_json(list, userid)
    list.each do |article|
      new_article = Article.new
      new_article.item_num = article[1]["item_id"]
      new_article.title = article[1]["title"]
      new_article.url = article[1]["url"]
      new_article.time_added = article[1]["time_added"]
      new_article.time_updated = article[1]["time_updated"]
      new_article.state = article[1]["state"]
      new_article.shortlink = URI(article[1]["url"]).host.sub(/^www\./,"")
      new_article.user_id = userid
      new_article.save
    end
  end
  
  # def self.match_source(shortlink)
  #   Source.all.each do |source|
  #     if source.name == shortlink
  #       return source.id
  #     else
  #     end
  #   end
  #   return 6
  # end
  
  def match_source
    shortlink = self.shortlink
    Source.all.each do |source|
      if source.name == shortlink
        return source.id
      else
      end
    end
    return 6
  end

  def self.update_state(list)
    list.each do |article|
      current_article = Article.find_by_item_num article[1]["item_id"]
      current_article.update_attribute :state, article[1]["state"]
    end
  end
end




