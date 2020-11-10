class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  enum user_type: { student: 'student', teacher: 'teacher', super_admin: 'super_admn' }

  mount_uploader :avatar, ImageUploader

  has_many :course_students, foreign_key: :student_id,  dependent: :destroy 
  has_many :taught_courses, class_name: "Course", foreign_key: "teacher_id",  dependent: :destroy 
  has_many :courses, :through => :course_students
  has_many :group_users,  dependent: :destroy 
  has_many :groups, :through => :group_users
  

  validates :name, presence: true
  validates :email, presence: true
  validates :user_type, presence: true, inclusion: { in: %w(student teacher super_admin) }

  COURSE_MONTHLY_LIMIT = 3

  def user_email_id
    "#{self.email} (##{self.id})"
  end

  def is_eligible?
    self.course_students.where("created_at >= ? AND created_at<= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).count < COURSE_MONTHLY_LIMIT
  end
end
