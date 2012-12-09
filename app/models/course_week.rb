class CourseWeek < ActiveRecord::Base

  attr_accessible :lecture_course, :staff_member, :week

  # = Validations =
  validates_presence_of :lecture_course, :staff_member, :week

  # = Relationships =
  belongs_to :lecture_course
  belongs_to :staff_member
  belongs_to :week
end
