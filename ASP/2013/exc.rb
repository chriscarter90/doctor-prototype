#!/usr/bin/ruby

require 'tinytable'
require 'pp'

def format_allocations(allocations)
  allocs = {}
  allocations.each do |a|
    week   = a.match(/session\([^,]+,[^,]+,(\d+)/)[1]
    term   = a.match(/session\([^,]+,[^,]+,[^,]+,(\d+)/)[1]
    day    = a.match(/session\((\w+)/)[1]
    time   = a.match(/session\([^,]+,(\d+)/)[1]
    course = a.match(/allocated\("([^"]+)"/)[1]
    room   = a.match(/session\(.*\),"(\d+)"/)[1]

    allocs[term] ||= {}
    allocs[term][week] ||= {}
    allocs[term][week][day] ||= {}
    allocs[term][week][day][time] ||= []
    allocs[term][week][day][time] << "#{course} (R: #{room})"
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

answers = []
threads = []

3.times do |i|
  threads[i] = Thread.new {
    allocations = `clingo --const t=#{i+1} *.lp 2> /dev/null`

    lines = allocations.split("\n")
    if lines.first.match(/UNSATISFIABLE/)
      puts "No solutions found."
    else
      answers += find_optimal_answer(lines).split(/\s/)
    end
  }
end

threads.map(&:join)

allocs = format_allocations(answers)

days = %w[mon tues wed thurs fri]

allocs.each do |term|
  puts "Term #{term[0]}"
  term_data = term[1]
  term_data.each do |week|
    puts "Week #{week[0]}"
    week_data = week[1]
    table = TinyTable::Table.new
    table.header = [""] + days

    "1".upto("9") do |i|
      line = [i]

      days.each do |day|
        if week_data[day].nil?
          line << ""
        elsif week_data[day][i].nil?
          line << ""
        else
          line << week_data[day][i].join(", ")
        end
      end
      table << line
    end

    puts table.to_text
  end
end
