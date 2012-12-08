#######
#
# This file will be run on every deploy, so make sure the changes here are non-destructive
#
#######

days = [
  { :no => 1, :name => "Monday" },
  { :no => 2, :name => "Tuesday" },
  { :no => 3, :name => "Wednesday" },
  { :no => 4, :name => "Thursday" },
  { :no => 5, :name => "Friday" },
  { :no => 6, :name => "Saturday" },
  { :no => 7, :name => "Sunday" }
]

days.each do |day|
  d = Day.find_or_initialize_by_no(day[:no])
  if d.new_record?
    d.name = day[:name]
    d.save!
  end
end
