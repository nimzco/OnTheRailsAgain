class AddColumnAncestryDepthToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :ancestry_depth, :integer, :default => 0
  end

  def self.down
  end
end
