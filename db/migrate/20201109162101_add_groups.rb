class AddGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, limit: 50
      t.text :description
      t.timestamps
    end
  end
end
