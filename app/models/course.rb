class Course < ApplicationRecord
  before_validation :generate_slug

  RUNNING = "running"
  ENDED = "ended"
  UPCOMING = "upcoming"
  belongs_to :teacher, class_name: "User"
  has_many :course_students
  has_many :students, :through => :course_students

  enum status: { active: 1, inactive: 0}

  validates :title, presence: true, uniqueness: true
  validates :slug, presence: true, format: { with: /([a-z]|\d)+/i }, uniqueness: true
  validates :summary, presence: true
  validates :content, presence: true

  scope :by_teacher, -> (teacher_id) { where(teacher_id: teacher_id)}

  def instructor
    self.teacher.name.titleize
  end

  def student_count
    self.course_students.admitted.count
  end

  def dissolve
    self.inactive!
    self.course_students.each do |s|
      s.cancelled!
    end
  end

  def url
    "/course/#{self.slug}"
  end

  def is_full?
    self.students.count >= self.student_limit
  end

  def has_applied? user
    self.students.where(id: user.id).any?
  end

  def self.upcoming_courses
    self.active
  end

  def self.ended_courses
    self.where(status: true).where(['end_date < ? && start_date < ?', DateTime.now, DateTime.now])
  end

  def self.running_courses
    self.where(status: true).where(['end_date > ? && start_date < ?', DateTime.now, DateTime.now])
  end

  def generate_slug
    if !self.slug || self.slug == ""
      self.slug = I18n.transliterate(self.title).downcase.gsub(/\W+/, "-")
    end
    # set status
    self.status = 1
  end

  def self.filter_response(result)
    response = []
    result.each do |c|
      course = {
        id: c.id,
        title: c.title.titleize,
        summary: c.summary,
        teacher: c.instructor,
        url: c.url
      }
      response << course
    end
    return response
  end

  def self.teacher_courses teacher_id
    self.by_teacher(teacher_id).order('start_date DESC')
  end

  def self.active
    self.where(status: true).where(['start_date > ?', DateTime.now])
  end
end
