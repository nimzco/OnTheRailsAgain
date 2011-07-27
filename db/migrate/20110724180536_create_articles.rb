class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title       , :unique => true
      t.text :introduction
      t.text :content
      t.integer :author_id

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
