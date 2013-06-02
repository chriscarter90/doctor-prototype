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
    types = [
      ['a', ''],
      ['b', ''],
      ['c', ''],
      ['b1', ' (LT-L)'],
      ['b2', ' (L-LT)'],
      ['b3', ' (L-TL)'],
      ['b4', ' (TL-L)'],
      ['c1', ' (LT-L)'],
      ['c2', ' (L-LT)'],
      ['c3', ' (L-TL)'],
      ['c4', ' (TL-L)']
    ]

    types.each do |type|
      options << ["Type #{type[0]}#{type[1]}", type[0]]
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
