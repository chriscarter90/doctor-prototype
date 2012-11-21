module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def lecture_courses_page
    lecture_courses_path
  end
end

RSpec.configuration.include NavigationHelpers
