class AddIntroductionToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :introduction, :text
  end

  def self.down
    remove_column :articles, :introduction
  end
end
