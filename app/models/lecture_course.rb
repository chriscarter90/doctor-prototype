class LectureCourse < ActiveRecord::Base

  attr_accessible :code, :title, :term, :classes, :lecturehours, :tutorialhours, :labhours, :weeklyhours, :popestimate, :popregistered, :year, :clashes_hidden, :scheduling_type

  # = Validations =
  validates_presence_of :code, :title, :term, :year

  # = Relationships =
  has_many :requirements, :dependent => :destroy
  has_many :lecturers, :dependent => :destroy
  has_many :staff_members, :through => :lecturers
  has_many :degree_classes, :through => :requirements
  has_many :course_weeks, :dependent => :destroy
  has_many :timetable_slots, :dependent => :destroy
  has_and_belongs_to_many :clashes
  has_and_belongs_to_many :unclashables
  belongs_to :year

  # = Scopes =
  scope :by_code, order('code')
  scope :has_lecturers, select('DISTINCT lecture_courses.*').joins(:lecturers).where('lecturers.role = ?', "Lecturer")
  scope :clashable, joins(:requirements => :degree_class).where("degree_classes.letteryr LIKE '%3' OR degree_classes.letteryr LIKE '%4' OR degree_classes.letteryr LIKE '%5'")

  scope :for_year, ->(year_no) do
    where("lecture_courses.code LIKE '#{year_no}%'")
  end

  scope :in_term, ->(term_no) do
    where("lecture_courses.term LIKE '%#{term_no}%'")
  end

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

  def display_name
    "#{code} - #{title}"
  end

  def to_ASP
    "course(\"#{code}\")."
  end

  def type_to_ASP
    if scheduling_type.present?
      "course_type(\"#{code}\", #{scheduling_type}).\n"
    end
  end
end
