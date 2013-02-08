class ClashesController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])

    @clashes = @year.clashes
  end
end
