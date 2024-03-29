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
  has_many :course_weeks
  has_many :timetable_slots
  has_and_belongs_to_many :clashes

  # = Scopes =
  scope :by_code, order('code')
  scope :has_lecturers, select('DISTINCT lecture_courses.*').joins(:lecturers).where('lecturers.role = ?', "Lecturer")

  def to_param
    code
  end

  def total_hours
    lectures = lecturehours || 0
    tutorials = tutorialhours || 0
    labs = labhours || 0

    lectures + tutorials + labs
  end

  def terms_taught
    term.split(",").map(&:to_i)
  end

  def taught_in_term?(term)
    terms_taught.include?(term.no)
  end

  def has_multiple_lecturers?
    return lecturers.only_lecturers.count > 1
  end
end
