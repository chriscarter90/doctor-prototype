class DegreeClassesController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])
    @degrees = @year.degree_classes.by_degreeyr
  end

  def show
    @year = Year.find_by_no(params[:year_id])
    @degree = @year.degree_classes.find_by_degreeyr(params[:id])
    @requirements = @degree.requirements
  end

  def import
    @year = Year.find_by_no(params[:year_id])
    tempfile = params[:file]
    FileUtils::cp(tempfile.tempfile.path, Rails.root.join("tmp", tempfile.original_filename))
    Resque.enqueue(DegreeClassImporterWorker, @year.no, tempfile.original_filename)
    redirect_to year_path(@year), :notice => "Importing degree classes."
  end
end
