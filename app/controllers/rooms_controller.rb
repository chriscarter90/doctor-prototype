class RoomsController < ApplicationController
  def index
    @rooms = Room.by_no
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      redirect_to rooms_path, :notice => "Room was created successfully."
    else
      flash[:warning] = "Room could not be created."
      render :new
    end
  end

  def edit
    @room = Room.find_by_no(params[:id])
  end

  def update
    @room = Room.find_by_no(params[:id])
    if @room.update_attributes(params[:room])
      redirect_to rooms_path, :notice => "Room was successfully updated."
    else
      flash[:warning] = "Room could not be updated."
      render :edit
    end
  end
end
