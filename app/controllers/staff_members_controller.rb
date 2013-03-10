class StaffMembersController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])
    @staff = @year.staff_members.by_login
  end

  def show
    @year = Year.find_by_no(params[:year_id])
    @staff_member = @year.staff_members.find_by_login(params[:id])
    @lecturers = @staff_member.lecturers
  end
end
