module RoomsHelper
  def room_type_options(room)
    options_for_select([["Lecture", "lecture"], ["Lab", "lab"]], room.room_type)
  end

  def room_size_options(room)
    options = []
    ['small', 'medium', 'large'].each do |size|
      options << [size.capitalize, size]
    end

    options_for_select(options, room.size)
  end
end
