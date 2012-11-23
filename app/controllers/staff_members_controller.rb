class StaffMembersController < ApplicationController
  def index
    @staff = StaffMember.by_login
  end

  def show
    @staff_member = StaffMember.find_by_login(params[:id])
    @lecturers = @staff_member.lecturers
  end
end
