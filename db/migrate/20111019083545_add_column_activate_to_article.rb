class AddColumnActivateToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :activate, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :articles, :activate
  end
end
