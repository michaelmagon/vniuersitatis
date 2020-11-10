ActiveAdmin.register Course do

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :summary
    column :cover_source
    column :student_limit
    column :start_date
    column :end_date
    actions
  end

  filter :title
  filter :status
  filter :start_date
  filter :end_date

end
