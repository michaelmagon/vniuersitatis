ActiveAdmin.register Group do
  permit_params :name, :description

  index do
    selectable_column
    id_column
    column :name
    column :description
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :cover_image
    end
    f.actions
  end

end
