module CourseWeeksHelper
  def find_existing_hours(course, week, lecturer, type)
    if CourseWeek.exists?(:lecture_course_id => course, :week_id => week, :staff_member_id => lecturer, :session_type => type)
      course.course_weeks.where(:week_id => week).where(:staff_member_id => lecturer).where(:session_type => type).first.hours
    else
      0
    end
  end

  def investigation_class(course)
    course.total_hours == 27 ? "standard" : "investigation"
  end
end
