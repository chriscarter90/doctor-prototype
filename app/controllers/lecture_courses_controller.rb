class LectureCoursesController < ApplicationController
  def index
    @courses = LectureCourse.all
  end

  def show
    @course = LectureCourse.find(params[:id])
  end
end
