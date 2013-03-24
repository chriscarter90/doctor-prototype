class RequirementsController < ApplicationController
  def import
    @year = Year.find_by_no(params[:year_id])
    tempfile = params[:file]
    FileUtils::cp(tempfile.tempfile.path, Rails.root.join("tmp", tempfile.original_filename))
    Resque.enqueue(RequirementImporterWorker, @year.no, tempfile.original_filename)
    redirect_to year_path(@year), :notice => "Importing requirements."
  end
end