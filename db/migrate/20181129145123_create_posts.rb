class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :img
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
