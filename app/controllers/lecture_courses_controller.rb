class LectureCoursesController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])
    @courses = @year.lecture_courses.by_code
  end

  def show
    @year = Year.find_by_no(params[:year_id])
    @course = @year.lecture_courses.find_by_code(params[:id])
    @requirements = @course.requirements
    @lecturers = @course.lecturers
  end
end
