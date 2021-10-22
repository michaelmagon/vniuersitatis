class AddCourseTags < ActiveRecord::Migration[6.0]
  def self.up
    create_table :tags do |t|
      t.string :name
      t.string :color
      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
