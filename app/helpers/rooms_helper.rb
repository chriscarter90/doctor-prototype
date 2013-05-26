module RoomsHelper
  def room_type_options(room)
    options_for_select([["Lecture", "lecture"], ["Lab", "lab"]], room.room_type)
  end
end
