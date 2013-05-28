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

  def timetable_slots
    @year = Year.find_by_no(params[:year_id])
    @room = @year.rooms.find_by_no(params[:id])
    @time_slots = TimeSlot.scoped
    @slots = group_slots(@year.timetable_slots.where(:room_id => @room.id))
  end

  private
  def group_slots(slots)
    by_term = slots.group_by { |s| s.week.term }
    by_term_and_time_slot = {}
    by_term.each_pair do |term, term_slots|
      by_term_and_time_slot[term] = term_slots.group_by { |t| t.time_slot }
      by_term_and_time_slot[term].each_pair do |slot, slot_allocs|
        by_term_and_time_slot[term][slot] = slot_allocs.group_by { |s| s.lecture_course }
      end
    end
    by_term_and_time_slot
  end
end
