class TimetableSlotsController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])
    @rooms = @year.rooms
    @terms = @year.terms
  end
end
