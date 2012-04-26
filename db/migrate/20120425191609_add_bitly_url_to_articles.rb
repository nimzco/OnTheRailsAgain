class AddBitlyUrlToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :bitly_url, :string
  end
end
