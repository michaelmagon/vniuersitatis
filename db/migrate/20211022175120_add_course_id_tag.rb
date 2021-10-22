class AddCourseIdTag < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :course_id, :integer
  end
end
