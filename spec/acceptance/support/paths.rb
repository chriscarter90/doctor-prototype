module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def home_page
    '/'
  end

  def lecture_courses_page
    lecture_courses_path
  end

  def lecture_course_page(course)
    lecture_course_path(course)
  end

  def degree_classes_page
    degree_classes_path
  end

  def degree_class_page(degree)
    degree_class_path(degree)
  end

  def staff_members_page
    staff_members_path
  end

  def staff_member_page(staff_member)
    staff_member_path(staff_member)
  end

  def rooms_page
    rooms_path
  end

  def edit_room_page(room)
    edit_room_path(room)
  end
end

RSpec.configuration.include NavigationHelpers
