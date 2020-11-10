class AddUploadImageSupport < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :cover_image, :string
    add_column :users, :avatar, :string
  end
end
