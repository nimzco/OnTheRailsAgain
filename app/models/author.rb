# encoding: utf-8
class Author < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible         :name, :email, :password, :password_confirmation, :remember_me
  
  validates_uniqueness_of :name
  
  has_and_belongs_to_many :articles

end
