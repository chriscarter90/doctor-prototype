class LectureCoursesController < ApplicationController
  def index
    @courses = LectureCourse.all
  end
end
