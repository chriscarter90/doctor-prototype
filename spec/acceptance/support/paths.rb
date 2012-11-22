module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def lecture_courses_page
    lecture_courses_path
  end

  def lecture_course_page(course)
    lecture_course_path(course)
  end
end

RSpec.configuration.include NavigationHelpers
