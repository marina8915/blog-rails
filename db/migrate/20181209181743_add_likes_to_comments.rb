class AddLikesToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :plus, :integer
    add_column :comments, :minus, :integer
  end
end
