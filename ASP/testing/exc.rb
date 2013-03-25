#!/usr/bin/ruby

require 'tinytable'
require 'pp'

def format_allocations(allocations)
  allocs = {}
  allocations.each do |a|
    term   = a.match(/session\([^,]+,[^,]+,(\d+)/)[1]
    day    = a.match(/session\((\w+)/)[1]
    time   = a.match(/session\([^,]+,(\d+)/)[1]
    course = a.match(/allocated\("([^"]+)"/)[1]
    room   = a.match(/session\(.*\),"(\d+)"/)[1]

    allocs[term] ||= {}
    allocs[term][day] ||= {}
    allocs[term][day][time] ||= []
    allocs[term][day][time] << "#{course} (R: #{room}))"
  end
  allocs
end


def find_optimal_answer(lines)
  last_line = -1
  lines.each_with_index do |l, i|
    if l =~ /Answer: \d+/
      last_line = i+1
    end
  end
  lines[last_line]
end

allocations = `clingo *.lp`

lines = allocations.split("\n")
if lines.first.match(/UNSATISFIABLE/)
  puts "No solutions found."
else
  answers = find_optimal_answer(lines).split(/\s/)
  allocs = format_allocations(answers)

  days = %w[mon tues wed thurs fri]

  allocs.each do |term|
    puts "Term #{term[0]}"
    term = term[1]
    table = TinyTable::Table.new
    table.header = [""] + days

    "1".upto("9") do |i|
      line = [i]

      days.each do |day|
        if term[day].nil?
          line << ""
        elsif term[day][i].nil?
          line << ""
        else
          line << term[day][i].join(", ")
        end
      end
      table << line
    end

    puts table.to_text
  end
end
