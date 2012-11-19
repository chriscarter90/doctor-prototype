class Requirement < ActiveRecord::Base

  attr_accessible :degree_class, :lecture_course, :required

  # = Validations =
  validates_presence_of :degree_class, :lecture_course, :required

  # = Relationships =
  belongs_to :degree_class
  belongs_to :lecture_course
end
