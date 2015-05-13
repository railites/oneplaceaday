class RemoveColumnLikesCountFromPosts < ActiveRecord::Migration
  def change
  	remove_column :posts, :likes_count
  end
end
