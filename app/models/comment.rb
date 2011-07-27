class Comment < ActiveRecord::Base
  belongs_to :article
  has_ancestry
  
  validates_presence_of :username, :content, :article_id
  
end
