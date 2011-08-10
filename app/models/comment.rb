class Comment < ActiveRecord::Base
  belongs_to            :article
  validates_associated  :article
  has_ancestry :cache_depth => true, :depth_cache_column => :ancestry_depth

  validates_presence_of :username, :content, :article_id
  
end
