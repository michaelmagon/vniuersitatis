require "rails_helper"
require_relative "../support/devise"

describe CoursesController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryBot.create(:user, user_type: 'super_admn')
    sign_in @user

    @teacher = create(:user,user_type: 'teacher')
    @student = create(:user,user_type: 'student')
    @course = create(:course)
  end
  describe "GET index" do
    it "returns success" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "Create Course" do 

    it "should create course and redirect to my courses path" do
      expect {
        post :create_course, params: { 
          course: {
            title: "Title",
            content: "Content sample",
            summary: "summary sample",
            cover_source: "cover source",
            teacher_id: @teacher.id,
            student_limit: 20,
            start_date: "2020-08-18 14:25:15",
            end_date: "2020-08-18 14:25:15",
            slug: "title"
          }
        }
      }.to change {Course.count}

      expect(response).to redirect_to('/my_courses')
    end
  end

  describe "admit students" do
    it "should admit student and send email" do
      @course_student = create(:course_student,student: @student, course: @course)
      expect { get :admit, params: {student_id: @student.id, course_slug: @course.slug} }.to change { ActionMailer::Base.deliveries.count }.by(1)
      @course_student.reload
      expect(@course_student.admitted?).to eq(true)
    end
  end

  describe "apply course" do
    it "should allow students to apply to courses" do
      expect { get :apply_course, params:{user_id: @student.id, course_id: @course.slug} }.to change { CourseStudent.count}
    end
  end

end