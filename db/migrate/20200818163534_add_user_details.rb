class AddUserDetails < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, limit: 50
    add_column :users, :user_type, :string, limit: 10
  end
end
