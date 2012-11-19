class Requirement < ActiveRecord::Base

  attr_accessible :degree_class_id, :lecture_course_id, :required

  # = Validations =
  validates_presence_of :degree_class_id, :lecture_course_id, :required

  # = Relationships =
  belongs_to :degree_class
  belongs_to :lecture_course
end
