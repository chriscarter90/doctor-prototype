class LectureCourse < ActiveRecord::Base

  attr_accessible :code, :title, :term, :classes, :lecturehours, :tutorialhours, :labhours, :weeklyhours, :popestimate, :popregistered

  # = Validations =
  validates_uniqueness_of :code
  validates_presence_of :code, :title, :term

  # = Relationships =
  has_many :requirements
  has_many :lecturers
  has_many :staff_members, :through => :lecturers
  has_many :degree_classes, :through => :requirements

  # = Scopes =
  scope :by_code, order('code')

  def to_param
    code
  end
end
