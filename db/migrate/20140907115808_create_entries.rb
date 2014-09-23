class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.belongs_to :user
      t.string :title
      t.string :uuid
      t.integer :stock_count, default: 0, null: false
      t.integer :comment_count, default: 0, null: false
      t.integer :hatebu_count, default: 0, null: false
      t.datetime :entry_created
      t.timestamps
    end

    create_table :tags do |t|
      t.string :tag_name
    end

    create_table :entries_tags do |t|
      t.belongs_to :entry
      t.belongs_to :tag
    end

    create_table :users do |t|
      t.string :user_name
      t.integer :following_users, default: 0, null: false
      t.integer :followers, default: 0
      t.integer :items, default: 0
      t.timestamps
    end
  end
end
