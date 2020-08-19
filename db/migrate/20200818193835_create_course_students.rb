class CreateCourseStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :course_students do |t|
      t.references :student, index: true
      t.references :course, index: true
      t.string :status, limit: 15, default: 'pending'
      t.timestamps
    end

    add_foreign_key :course_students, :users, column: :student_id, primary_key: :id
  end
end
