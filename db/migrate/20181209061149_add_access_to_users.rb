class AddAccessToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :access, :boolean
  end
end
