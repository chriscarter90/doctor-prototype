class CourseWeeksController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])
    @terms = @year.terms.in_order
    @courses = LectureCourse.by_code
  end

  def update
    @year = Year.find_by_no(params[:year_id])

    course_weeks = params[:course_weeks]

    if course_weeks
      courses = LectureCourse.by_code

      courses.each do |c|
        c.course_weeks.for_year(@year).destroy_all

        allocations = course_weeks.delete(c.code)

        if allocations
          # Update the course to reflect whether the lecturers are merged or not
          merged_lecturers = allocations.delete("merged_lecturers")
          c.merged_lecturers = merged_lecturers.present?
          c.save!
          c.reload

          lecture_allocations = allocations.delete("lectures")
          if lecture_allocations
            # If they are merged, only add rows with no staff_member_id
            if c.merged_lecturers
              lecture_allocations.select! { |k, _| k == "all" }
              lecture_allocations.each do |_, term_allocations|
                term_allocations.each do |term_no, week_allocations|
                  term = @year.terms.find_by_no(term_no)
                  if c.taught_in_term?(term)
                    week_allocations.each do |week_no, no_hours|
                      week = term.weeks.find_by_no(week_no)
                      if week
                        hours = no_hours.to_i
                        CourseWeek.create!(:lecture_course => c, :week => week, :staff_member => nil, :hours => hours, :session_type => "Lecture")
                      end
                    end
                  end
                end
              end
            # If they are not merged, add rows for each staff member
            else
              lecture_allocations.reject! { |k, _| k == "all" }
              lecture_allocations.each do |login, term_allocations|
                staff = StaffMember.find_by_login(login)
                term_allocations.each do |term_no, week_allocations|
                  term = @year.terms.find_by_no(term_no)
                  if c.taught_in_term?(term)
                    week_allocations.each do |week_no, no_hours|
                      week = term.weeks.find_by_no(week_no)
                      if week
                        hours = no_hours.to_i
                        CourseWeek.create!(:lecture_course => c, :week => week, :staff_member => staff, :hours => hours, :session_type => "Lecture")
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
              if c.taught_in_term?(term)
                week_allocations.each do |week_no, no_hours|
                  week = term.weeks.find_by_no(week_no)
                  if week
                    hours = no_hours.to_i
                    CourseWeek.create!(:lecture_course => c, :week => week, :staff_member => nil, :hours => hours, :session_type => "Tutorial")
                  end
                end
              end
            end
          end

          lab_allocations = allocations.delete("labs")
          if lab_allocations
            lab_allocations.each do |term_no, week_allocations|
              term = @year.terms.find_by_no(term_no)
              if c.taught_in_term?(term)
                week_allocations.each do |week_no, no_hours|
                  week = term.weeks.find_by_no(week_no)
                  if week
                    hours = no_hours.to_i
                    CourseWeek.create!(:lecture_course => c, :week => week, :staff_member => nil, :hours => hours, :session_type => "Lab")
                  end
                end
              end
            end
          end
        else
          c.merged_lecturers = false
          c.save!
        end
      end
    else
      CourseWeek.for_year(@year).destroy_all
    end

    redirect_to year_path(@year), :notice => "Selections were updated successfully."
  end
end
