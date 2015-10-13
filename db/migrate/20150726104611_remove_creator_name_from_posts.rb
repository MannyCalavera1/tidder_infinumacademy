class RemoveCreatorNameFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :creator_name, :string
  end
end
