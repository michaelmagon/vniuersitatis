ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Courses" do
          ul do
            Course.first(5).map do |c|
              li link_to(c.title, admin_course_path(c))
            end
          end
        end
      end

      column do
        panel "Users" do
          ul do
            User.first(5).map do |u|
              li link_to(u.name, admin_user_path(u))
            end
          end
        end
      end

      column do
        panel "Groups" do
          ul do
            Group.first(5).map do |g|
              li link_to(g.name, admin_group_path(g))
            end
          end
        end
      end
    end
  end 
end
