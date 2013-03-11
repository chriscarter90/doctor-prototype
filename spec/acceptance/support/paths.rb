module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def home_page
    '/'
  end

  def lecture_courses_page(year)
    year_lecture_courses_path(year)
  end

  def lecture_course_page(year, course)
    year_lecture_course_path(year, course)
  end

  def degree_classes_page(year)
    year_degree_classes_path(year)
  end

  def degree_class_page(year, degree)
    year_degree_class_path(year, degree)
  end

  def staff_members_page(year)
    year_staff_members_path(year)
  end

  def staff_member_page(year, staff_member)
    year_staff_member_path(year, staff_member)
  end

  def rooms_page(year)
    year_rooms_path(year)
  end

  def new_room_page(year)
    new_year_room_path(year)
  end

  def edit_room_page(year, room)
    edit_year_room_path(year, room)
  end

  def years_page
    years_path
  end

  def new_year_page
    new_year_path
  end

  def year_page(year)
    year_path(year)
  end
end

RSpec.configuration.include NavigationHelpers
