class AddUrlCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :slug, :string, limit: 50
  end
end
