class CreateWishlist < ActiveRecord::Migration[6.0]
  def change
    create_table :wishlists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :course_name
    end
  end
end
