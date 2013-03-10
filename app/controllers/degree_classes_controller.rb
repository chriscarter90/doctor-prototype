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
end
