module ClashesHelper
  def clash_status(course1, course2, year)
    if course1 == course2
      return "self"
    end

    course1.unclashables.for_year(year).each do |u|
      if u.lecture_courses.include?(course2)
        return "unclashable"
      end
    end

    "can-clash"
  end

  def clashable_options_for_year(courses, course, year_no, selected)
    courses_for_year = courses.for_year(year_no) - [course]

    options_from_collection_for_select(courses_for_year, "code", "display_name", selected)
  end

  def clash_selected_value(course, year, aca_year_no, pos)
    clashes = course.clashes.for_year(year)
    if clashes.empty?
      nil
    else
      # Get the clash for the course in question
      clash = clashes.first
      clash_courses = clash.lecture_courses
      # If it's the first course in the clash
      if course == clash_courses.by_code.first
        # Get the clashes courses for the year (column) in question
        clash_courses_for_year = clash_courses.for_year(aca_year_no)
        # If there ARE any such courses
        if clash_courses_for_year.present?
          candidate = clash_courses_for_year[pos]
          if candidate
            if candidate == course
              nil
            else
              candidate.code
            end
          else
            nil
          end
        else
          nil
        end
      else
        nil
      end
    end
  end
end
