class RemoveAutorIdFromArticles < ActiveRecord::Migration
  def self.up
    remove_column :articles, :author_id
  end

  def self.down
  end
end
