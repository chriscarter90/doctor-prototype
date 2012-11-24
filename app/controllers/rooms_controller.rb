class RoomsController < ApplicationController
  def index
    @rooms = Room.by_no
  end
end
