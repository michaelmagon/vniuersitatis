
class TestSeed  
  CURRENT_COURSE_SLUG = "sample-of-current-course"
  ENDED_COURSE_SLUG = "sample-of-ended-course"
  UPCOMING_COURSE_SLUG = "sample-of-upcoming-course"

  STUDENT_USER = "samplestudent@user"
  TEACHER_USER = "sampleteacher@user"
  ADMIN_USER = "samplesadmin@user"

  USERS = [STUDENT_USER, TEACHER_USER]
  COURSES = [CURRENT_COURSE_SLUG, ENDED_COURSE_SLUG, UPCOMING_COURSE_SLUG]

  def self.clear_seed
    USERS.each do |u|
      User.find_by_email(u).destroy if User.find_by_email(u)
    end

    COURSES.each do |c|
      course = Course.find_by_slug(c)
      course.course_students.destroy if course
      course.destroy if course
    end
  end

  def self.load_seed
    User.create(
      :email                 => "samplestudent@user",
      :name                  => "student User",
      :password              => "123456",
      :password_confirmation => "123456",
      :user_type             => "student"
    )

    teacher = User.create(
      :email                 => "sampleteacher@user",
      :name                  => "teacher User",
      :password              => "123456",
      :password_confirmation => "123456",
      :user_type             => "teacher"
    )

    Course.create(
      title: "sample of current course",
      content: "content",
      summary: "summary",
      cover_source: "https://images.unsplash.com/photo-1494253109108-2e30c049369b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
      teacher: teacher,
      status: 1,
      student_limit: 20,
      start_date: Date.yesterday,
      end_date: Date.new(2021, 5, 12)
    )

    Course.create(
      title: "sample of ended course",
      content: "content content",
      summary: "interesting summary",
      cover_source: "https://images.unsplash.com/photo-1508138221679-760a23a2285b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
      teacher: teacher,
      status: 1,
      student_limit: 20,
      start_date: Date.new(2020, 1, 12),
      end_date: Date.new(2020, 2, 12)
    )

    Course.create(
      title: "sample of upcoming course",
      content: "content content content",
      summary: "another interesting summary",
      cover_source: "https://images.unsplash.com/photo-1508138221679-760a23a2285b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
      teacher: teacher,
      status: 1,
      student_limit: 20,
      start_date: Date.new(2021, 1, 12),
      end_date: Date.new(2021, 3, 12)
    )
  end

  def self.get_user(user)
    email = ''
    case user
    when "student"
      email = STUDENT_USER
    when "teacher"
      email = TEACHER_USER
    else
      email = ADMIN_USER
    end
  end

  def self.reload_seed
    self.clear_seed
    puts "=======cleared seed==========="
    self.load_seed
    puts "=======loaded seed==========="
  end

end  