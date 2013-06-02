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

  def update_course_weeks
    @year = Year.find_by_no(params[:year_id])
    @course = @year.lecture_courses.find_by_code(params[:id])
    @course.course_weeks.for_year(@year).destroy_all

    allocations = params[:course_weeks]

    if allocations
      # Update the course to reflect whether the lecturers are merged or not
      merged_lecturers = allocations.delete("merged_lecturers")
      scheduling_type = allocations.delete("scheduling_type")
      size = allocations.delete("size")
      @course.merged_lecturers = merged_lecturers.present?
      @course.scheduling_type = scheduling_type
      @course.size = size
      @course.save!
      @course.reload

      lecture_allocations = allocations.delete("lectures")
      if lecture_allocations
        # If they are merged, only add rows with no staff_member_id
        if @course.merged_lecturers
          lecture_allocations.select! { |k, _| k == "all" }
          lecture_allocations.each do |_, term_allocations|
            term_allocations.each do |term_no, week_allocations|
              term = @year.terms.find_by_no(term_no)
              if @course.taught_in_term?(term)
                week_allocations.each do |week_no, no_hours|
                  week = term.weeks.find_by_no(week_no)
                  if week
                    hours = no_hours.to_i
                    CourseWeek.create!(:lecture_course => @course, :week => week, :staff_member => nil, :hours => hours, :session_type => "Lecture")
                  end
                end
              end
            end
          end
        # If they are not merged, add rows for each staff member
        else
          lecture_allocations.reject! { |k, _| k == "all" }
          lecture_allocations.each do |login, term_allocations|
            staff = @year.staff_members.find_by_login(login)
            term_allocations.each do |term_no, week_allocations|
              term = @year.terms.find_by_no(term_no)
              if @course.taught_in_term?(term)
                week_allocations.each do |week_no, no_hours|
                  week = term.weeks.find_by_no(week_no)
                  if week
                    hours = no_hours.to_i
                    CourseWeek.create!(:lecture_course => @course, :week => week, :staff_member => staff, :hours => hours, :session_type => "Lecture")
                  end
                end
              end
            end
          end
        end
      end

      tutorial_allocations = allocations.delete("tutorials")
      if tutorial_allocations
        tutorial_allocations.each do |term_no, week_allocations|
          term = @year.terms.find_by_no(term_no)
          if @course.taught_in_term?(term)
            week_allocations.each do |week_no, no_hours|
              week = term.weeks.find_by_no(week_no)
              if week
                hours = no_hours.to_i
                CourseWeek.create!(:lecture_course => @course, :week => week, :staff_member => nil, :hours => hours, :session_type => "Tutorial")
              end
            end
          end
        end
      end

      lab_allocations = allocations.delete("labs")
      if lab_allocations
        lab_allocations.each do |term_no, week_allocations|
          term = @year.terms.find_by_no(term_no)
          if @course.taught_in_term?(term)
            week_allocations.each do |week_no, no_hours|
              week = term.weeks.find_by_no(week_no)
              if week
                hours = no_hours.to_i
                CourseWeek.create!(:lecture_course => @course, :week => week, :staff_member => nil, :hours => hours, :session_type => "Lab")
              end
            end
          end
        end
      end
    else
      @course.merged_lecturers = false
      @course.save!
    end

    Resque.enqueue(CourseWeekWriterWorker, @year.no)
    redirect_to year_lecture_course_path(@year, @course), :notice => "Selections were updated successfully."
  end
end
