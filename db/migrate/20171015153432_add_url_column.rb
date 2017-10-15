class AddUrlColumn < ActiveRecord::Migration
  def change
    add_column :entries, :url, :string, null: true, after: :uuid
  end
end
