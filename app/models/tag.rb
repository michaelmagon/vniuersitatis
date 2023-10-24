class Tag < ApplicationRecord
  belongs_to :course

  def tag_color
    "#{name}-#{color}"
  end

  def course_color
    "#{title}-#{color}"
  end

  delegate :title, to: :course
end
