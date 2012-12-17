class CourseWeeksController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])
    @terms = @year.terms.in_order
    @courses = LectureCourse.by_code
  end

  def update
    #TODO: Limit this to only the courses which need teaching
    @year = Year.find_by_no(params[:year_id])

    course_weeks = params[:course_weeks]
    courses = LectureCourse.by_code

    if course_weeks
      courses.each do |c|
        c.course_weeks.for_year(@year).destroy_all
        allocations = course_weeks.delete(c.code)
        if allocations
          allocations.each do |login, term_allocations|
            staff = StaffMember.find_by_login(login)
            term_allocations.each do |term_no, week_allocations|
              term = @year.terms.find_by_no(term_no)
              if c.taught_in_term?(term)
                week_allocations.each do |week_no|
                  week = term.weeks.find_by_no(week_no)
                  if week
                    CourseWeek.create!(:lecture_course => c, :week => week, :staff_member => staff)
                  end
                end
              end
            end
          end
        end
      end
    else
      CourseWeek.for_year(@year).destroy_all
    end

    redirect_to year_path(@year), :notice => "Selections were updated successfully."
  end
end
