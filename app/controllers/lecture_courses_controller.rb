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

  def show_clashes
    @year = Year.find_by_no(params[:year_id])
    @course = @year.lecture_courses.find_by_code(params[:id])
    @course.update_attribute(:clashes_hidden, false)

    render :nothing => true
  end

  def hide_clashes
    @year = Year.find_by_no(params[:year_id])
    @course = @year.lecture_courses.find_by_code(params[:id])
    @course.update_attribute(:clashes_hidden, true)

    render :nothing => true
  end

  def import
    @year = Year.find_by_no(params[:year_id])
    tempfile = params[:file]
    FileUtils::cp(tempfile.tempfile.path, Rails.root.join("tmp", tempfile.original_filename))
    Resque.enqueue(LectureCourseImporterWorker, @year.no, tempfile.original_filename)
    redirect_to year_path(@year), :notice => "Importing lecture courses."
  end
end
