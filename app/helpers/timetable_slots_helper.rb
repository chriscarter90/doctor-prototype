module TimetableSlotsHelper
  def get_week_ranges(weeks)
    weeks.to_enum(:chunk).with_index { |x, idx| x - idx }.map do |diff, group|
      [group.first, group.last]
    end.map { |x| "#{x.first}-#{x.last}" }.join(", ")
  end
end
