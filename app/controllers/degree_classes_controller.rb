class DegreeClassesController < ApplicationController
  def index
    @degrees = DegreeClass.all
  end

  def show
    @degree = DegreeClass.find_by_degreeyr(params[:id])
  end
end
