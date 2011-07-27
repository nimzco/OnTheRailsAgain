class Article < ActiveRecord::Base

  has_and_belongs_to_many :authors
  has_and_belongs_to_many :tags

  has_many                :comments

  validates_associated    :authors
  validates_associated    :tags

  validates_uniqueness_of :title
  validates_presence_of   :title, :introduction, :content

end
