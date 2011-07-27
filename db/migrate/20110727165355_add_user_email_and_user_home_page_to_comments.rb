class AddUserEmailAndUserHomePageToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_email, :string
    add_column :comments, :user_homepage, :string
  end

  def self.down
    remove_column :comments, :user_email, :string
    remove_column :comments, :user_homepage, :string  
  end
end
