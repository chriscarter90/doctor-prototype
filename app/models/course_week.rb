class CourseWeek < ActiveRecord::Base

  attr_accessible :lecture_course, :staff_member, :week, :hours, :session_type

  # = Validations =
  validates_presence_of :lecture_course, :week, :hours, :session_type

  # = Relationships =
  belongs_to :lecture_course
  belongs_to :staff_member
  belongs_to :week

  # = Scopes =
  scope :for_year, ->(year) do
    joins(:week => :term).where("terms.year_id = ?", year.id)
  end

  def to_ASP
    "week_term_hours(\"#{lecture_course.code}\", #{hours}, #{week.no}, #{week.term.no}, #{session_type.downcase})."
  end
end
