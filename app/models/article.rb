class Article < ActiveRecord::Base
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :authors
  has_many                :comments
  
  validates_uniqueness_of :title
  validates_presence_of   :introduction, :content

end
