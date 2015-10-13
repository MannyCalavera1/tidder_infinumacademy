class AddDefaultValueToCounterCaches < ActiveRecord::Migration
  def change
    change_column :posts, :upvotes_count, :integer, :default => 0
    change_column :posts, :comments_count, :integer, :default => 0
  end
end
