#!/usr/bin/ruby

require 'tinytable'

allocations = `clingo timetable.lp`

lines = allocations.split("\n")
if lines.first.match(/UNSATISFIABLE/)
  puts "No solutions found."
else
  answers = lines[1].split(/\s/)

  allocs = {}

  answers.each do |a|
    puts a
  end
end
