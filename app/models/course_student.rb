class CourseStudent < ApplicationRecord

  belongs_to :student, class_name: "User"
  belongs_to :course

  enum status: { admitted: 'admitted', pending: 'pending', declined: 'declined', cancelled: 'cancelled' }

  def self.all_pending
    self.where(status: :pending)
  end

  def self.all_admitted
    self.where(status: :admitted)
  end

  def self.all_active
    self.where.not(status: [:declined, :cancelled])
  end
  
  def self.all_declined
    self.where(status: :declined)
  end
 end
