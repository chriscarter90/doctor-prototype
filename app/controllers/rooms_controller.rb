class RoomsController < ApplicationController
  def index
    @year = Year.find_by_no(params[:year_id])
    @rooms = @year.rooms.by_no
  end

  def new
    @year = Year.find_by_no(params[:year_id])
    @room = @year.rooms.build
  end

  def create
    @year = Year.find_by_no(params[:year_id])
    @room = @year.rooms.build(params[:room])
    if @room.save
      Resque.enqueue(RoomWriterWorker, @year.no)
      redirect_to year_rooms_path(@year), :notice => "Room was created successfully."
    else
      flash[:warning] = "Room could not be created."
      render :new
    end
  end

  def edit
    @year = Year.find_by_no(params[:year_id])
    @room = @year.rooms.find_by_no(params[:id])
  end

  def update
    @year = Year.find_by_no(params[:year_id])
    @room = @year.rooms.find_by_no(params[:id])
    if @room.update_attributes(params[:room])
      Resque.enqueue(RoomWriterWorker, @year.no)
      redirect_to year_rooms_path(@year), :notice => "Room was successfully updated."
    else
      flash[:warning] = "Room could not be updated."
      render :edit
    end
  end

  def destroy
    @year = Year.find_by_no(params[:year_id])
    @room = @year.rooms.find_by_no(params[:id])
    @room.destroy
    redirect_to year_rooms_path(@year), :notice => "Room was deleted successfully."
  end
end
