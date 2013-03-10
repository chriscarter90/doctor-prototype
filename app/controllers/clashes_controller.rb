class ClashesController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])

    @clashes = @year.clashes
    @unclashables = @year.unclashables

    @courses = LectureCourse.has_lecturers.by_code.clashable
  end

  def new
    @year = Year.find_by_no(params[:year_id])
    @courses = LectureCourse.has_lecturers.by_code
    clash = @year.clashes.build
    render :partial => 'form', :locals => { :number => params[:number] }
  end

  def update
    @year = Year.find_by_no(params[:year_id])

    clashes = params[:clashes]

    @year.clashes.destroy_all

    clashes.each do |course, clash_courses|
      clash_courses = process_clashes(clash_courses)
      if clash_courses.present?
        clash_object = Clash.create!(:year => @year)
        clash_object.lecture_courses << @year.lecture_courses.find_by_code(course)
        clash_courses.each do |c|
          course_object = @year.lecture_courses.find_by_code(c)
          if !clash_object.lecture_courses.include?(course_object)
            clash_object.lecture_courses << course_object
          end
        end
      end
    end

    redirect_to year_path(@year), :notice => "Clashes were updated successfully."
  end

  private
  def process_clashes(clash_row)
    clash_row.delete_if { |elem| elem == "" }
  end
end
