class RenameSummaryToTableOfContentAndActivateToActivated < ActiveRecord::Migration
  def up
    rename_column :articles, :summary, :table_of_content
    rename_column :articles, :activate, :activated
  end

  def down
    rename_column :articles, :table_of_content, :summary
    rename_column :articles, :activated, :activate
  end
end
