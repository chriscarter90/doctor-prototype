1.upto(5) do |i|
  1.upto(9) do |t|
    day = Day.find_by_no(i)
    slot = day.time_slots.create!(:start_hour => t)
  end
end
