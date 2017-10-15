class AddLikeCountColumn < ActiveRecord::Migration
  def change
    add_column :entries, :like_count, :integer, default: 0, null: false, after: :uuid
    remove_column :entries, :stock_count, :integer
  end
end
