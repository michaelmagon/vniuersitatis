class UserMailer < ApplicationMailer
  default from: 'Admin <admin@schol.com>'
  
  def accepted_in_course(user, course)
    @user = user
    @course = course
    mail(:to => @user.email, :subject => "You have been accepted")
  end

  def rejected_in_course(user, course)
    @user = user
    @course = course
    mail(:to => @user.email, :subject => "You have been rejected")
  end
end
