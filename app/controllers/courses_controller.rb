class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_data, only: [:admit, :decline]
  load_and_authorize_resource except: :course

  def index
    @courses = Course.active.paginate(page: params[:page], per_page: 5) #change to available courses
  end

  def new
    @course = Course.new
  end

  def create_course
    @course = Course.new(course_params)
    @course.teacher = current_user

    if @course.save
      redirect_to my_courses_url
    else
      render json: @course.errors and return
    end
  end

  def destroy
    @course = Course.find_by_slug(params[:id])
    @course.dissolve
    redirect_to my_courses_url
  end

  def course
    @course = Course.find_by_slug(params[:id])
    @related_courses = Course.active.where.not(id: @course.id).take(4)
  end

  def my_courses
    @courses = Course.active
    if current_user.teacher?
      @courses = Course.teacher_courses(current_user.id).active
    elsif current_user.student?
      @courses = current_user.courses.active
    end
    @courses = @courses.paginate(page: params[:page], per_page: 5) 
  end

  def apply_course
    @course = Course.find_by_slug(params[:course_id])
    @user = User.find(params[:user_id])
    @application = CourseStudent.apply(@course,@user)

    if @application.save
      render json: @application, status: 200 and return
    else
      render json: @application.errors, status: 500 and return
    end
  end

  def admit
    @application.first.admitted!
    UserMailer.accepted_in_course(@user, @course).deliver_now
    render json: @application.first, status: 200 and return
  end

  def decline
    @application.first.declined!
    UserMailer.rejected_in_course(@user, @course).deliver_now
    render json: @application.first, status: 200 and return
  end

private

  def set_data
    @user = User.find(params[:student_id])
    @course = Course.find_by_slug(params[:course_slug])
    @application = CourseStudent.where(course: @course, student: @user)
  end

  def course_params
    params.require(:course).permit(:title, :summary, :content, :cover_source, :student_limit, :start_date, :end_date)
  end
end
