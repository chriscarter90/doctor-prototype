class UnclashablesController < ApplicationController
  def create
    @year = Year.find_by_no(params[:year_id])
    @course1 = @year.lecture_courses.find_by_code(params[:course1])
    @course2 = @year.lecture_courses.find_by_code(params[:course2])

    u = Unclashable.create!(:year => @year)
    u.lecture_courses << @course1
    u.lecture_courses << @course2

    render :nothing => true
  end

  def remove
    @year = Year.find_by_no(params[:year_id])
    @course1 = @year.lecture_courses.find_by_code(params[:course1])
    @course2 = @year.lecture_courses.find_by_code(params[:course2])

    unclashables = @course1.unclashables.for_year(@year)

    unclashables.each do |u|
      if u.lecture_courses.include?(@course2)
        u.destroy
      end
    end

    render :nothing => true
  end
end
