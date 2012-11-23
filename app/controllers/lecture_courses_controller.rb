class LectureCoursesController < ApplicationController
  def index
    @courses = LectureCourse.by_code
  end

  def show
    @course = LectureCourse.find_by_code(params[:id])
    @requirements = @course.requirements
    @lecturers = @course.lecturers
  end
end
