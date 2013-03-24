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

  def import
    @year = Year.find_by_no(params[:year_id])
    tempfile = params[:file]
    FileUtils::cp(tempfile.tempfile.path, Rails.root.join("tmp", tempfile.original_filename))
    Resque.enqueue(StaffMemberImporterWorker, @year.no, tempfile.original_filename)
    redirect_to year_path(@year), :notice => "Importing staff members."
  end
end
