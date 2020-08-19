module ApplicationHelper

  def current_role(user)
    if current_user.student? 
      link_label = "My Courses"
    elsif current_user.teacher?
      link_label = "Teacher's Portal" 
    end
  end
end
