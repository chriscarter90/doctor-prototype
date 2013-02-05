class Clash < ActiveRecord::Base

  attr_accessible :a_course, :b_course, :year

  # = Validations =
  validates_presence_of :a_course, :b_course, :year

  # = Relationships =
  belongs_to :a_course, :class_name => "LectureCourse", :foreign_key => "a_course_id"
  belongs_to :b_course, :class_name => "LectureCourse", :foreign_key => "b_course_id"
  belongs_to :year

end
