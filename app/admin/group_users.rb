ActiveAdmin.register GroupUser do

  permit_params :user_id, :group_id

  index do
    selectable_column
    id_column
    column :user_id
    column :group_id
    actions
  end

end
