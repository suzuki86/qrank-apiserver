class AddLikeCountColumn < ActiveRecord::Migration
  def change
    add_column :entries, :like_count, default: 0, null: false
    remove_column :entries, :like_count
  end
end
