class Comment < ActiveRecord::Base
  belongs_to :article
  validates_presence_of :username, :content

  has_ancestry
  
end