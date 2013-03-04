#!/usr/bin/ruby

require 'tinytable'
require 'pp'

def format_allocations(allocations)
  allocs = {}
  allocations.each do |a|
    day = a.match(/session\((\w+)/)[1]
    time = a.match(/session\([^,]+,(\d+)/)[1]
    course = a.match(/allocated\("([^"]+)"/)[1]
    room = a.match(/session\(.*\),"(\d+)"/)[1]
    allocs[day] ||= {}
    allocs[day][time] ||= []
    if !allocs[day][time].empty?
      allocs[day][time] << "#{course} (R: #{room})"
    else
      allocs[day][time] = ["#{course} (R: #{room})"]
    end
  end
  allocs
end

allocations = `clingo timetable.lp`

lines = allocations.split("\n")
if lines.first.match(/UNSATISFIABLE/)
  puts "No solutions found."
else
  answers = lines[1].split(/\s/)
  allocs = format_allocations(answers)

  days = %w[mon tues wed thurs fri]

  table = TinyTable::Table.new
  table.header = [""] + days

  1.upto(9) do |i|
    line = [i]

    days.each do |day|
      if allocs[day].nil? || allocs[day][i.to_s].nil?
        line << ""
      else
        line << allocs[day][i.to_s].join(", ")
      end
    end
    table << line
  end


  puts table.to_text
end
