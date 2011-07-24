class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :username
      t.string :content
      t.integer :article_id
      t.string :ancestry

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
