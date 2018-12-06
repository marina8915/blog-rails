class AddFieldsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :description, :text
    add_column :posts, :publish, :boolean
    add_column :posts, :video, :string
  end
end
