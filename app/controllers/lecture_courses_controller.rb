class LectureCoursesController < ApplicationController
  def index
    @courses = LectureCourse.all
  end

  def show
    @course = LectureCourse.find_by_code(params[:id])
  end
end
