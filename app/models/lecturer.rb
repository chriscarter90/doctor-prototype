class Lecturer < ActiveRecord::Base

  attr_accessible :staff_member, :lecture_course, :role, :staffhours, :term

  # = Validations =
  validates_presence_of :staff_member, :lecture_course, :role, :staffhours, :term

  # = Relationships =
  belongs_to :staff_member
  belongs_to :lecture_course
end
