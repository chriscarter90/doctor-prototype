class LectureCourse < ActiveRecord::Base

  attr_accessible :code, :title, :term, :classes, :lecturehours, :tutorialhours, :labhours, :weeklyhours, :popestimate, :popregistered

  # = Validations =
  validates_uniqueness_of :code
  validates_presence_of :code, :title, :term, :classes, :lecturehours, :tutorialhours, :labhours, :weeklyhours, :popestimate, :popregistered

  # = Relationships =
  has_many :requirements
  has_many :student_options
  has_many :lecturers
end
