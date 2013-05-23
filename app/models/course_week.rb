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
    if lecture_course.merged_lecturers? && staff_member.nil?
      "week_term_hours(\"#{lecture_course.code}\", #{hours}, #{week.no}, #{week.term.no}, all, #{session_type.downcase})."
    elsif !lecture_course.merged_lecturers? && staff_member.present?
      "week_term_hours(\"#{lecture_course.code}\", #{hours}, #{week.no}, #{week.term.no}, #{staff_member.login}, #{session_type.downcase})."
    end
  end
end
