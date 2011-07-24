class CreateArticleAuthorJoinTable < ActiveRecord::Migration
  def self.up
    create_table :articles_authors, :id => false do |t|
      t.integer :article_id
      t.integer :author_id
    end

  end

  def self.down
    drop_table :articles_authors
  end
end
