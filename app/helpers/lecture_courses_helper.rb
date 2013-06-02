module LectureCoursesHelper
  def find_existing_hours(course_weeks, week, lecturer, type)
    existing = course_weeks.where(:week_id => week, :staff_member_id => lecturer, :session_type => type)
    if existing.present?
      existing.first.hours
    else
      0
    end
  end

  def investigation_class(course)
    course.total_hours == 27 ? "standard" : "investigation"
  end

  def scheduling_type_options(course)
    options = []
    types = ('a'..'c').to_a + ('b1' .. 'b4').to_a + ('c1' .. 'c4').to_a
    types.each do |type|
      options << ["Type #{type}", type]
    end

    options_for_select(options, course.scheduling_type)
  end

  def course_size_options(course)
    options = []
    ['small', 'medium', 'large'].each do |size|
      options << [size.capitalize, size]
    end

    options_for_select(options, course.size)
  end
end
