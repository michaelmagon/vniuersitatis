class AddCoursesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title, limit: 50
      t.text :content
      t.string :summary, limit: 200
      t.string :cover_source
      t.references :teacher
      t.boolean :status
      t.integer :student_limit
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end

    add_foreign_key :courses, :users, column: :teacher_id, primary_key: :id
  end
end
