class TimetableGeneratorWorker
  @queue = :timetable_generator_queue

  def self.perform(year_no)
    year = Year.find_by_no(year_no)

    year.terms.each do |term|
      term.weeks.each do |week|
        week.timetable_slots.destroy_all
      end
    end

    answers = []
    threads = []

    asp_path = Rails.root.join("ASP", year_no.to_s)
    log_path = Rails.root.join("ASP", "asp.log")

    year.terms.each do |t|
      threads << Thread.new {
        allocations = `clingo --const t=#{t.no} #{asp_path}/*.lp 2>> #{log_path}`

        lines = allocations.split("\n")
        if lines.first.match(/UNSATISFIABLE/)
          puts "No solutions found."
        else
          answers += find_optimal_answer(lines).split(/\s/)
        end
        puts "Thread for term #{t.no} has finished."
      }
    end

    threads.map(&:join)

    puts "Finished."

    allocs = format_allocations(answers)

    import_allocations(year, allocs)

    year.update_attribute(:timetable_generated, true)
  end

  def self.format_allocations(allocations)
    allocs = {}
    allocations.each do |a|
      week   = a.match(/session\([^,]+,[^,]+,(\d+)/)[1]
      term   = a.match(/session\([^,]+,[^,]+,[^,]+,(\d+)/)[1]
      day    = a.match(/session\((\w+)/)[1]
      time   = a.match(/session\([^,]+,(\d+)/)[1]
      course = a.match(/allocated\("([^"]+)"/)[1]
      room   = a.match(/session\(.*\),"(\d+)"/)[1]
      type = a.match(/session\(.*\),"[^"]+",([^\)]+)/)[1]

      allocs[term] ||= {}
      allocs[term][week] ||= {}
      allocs[term][week][day] ||= {}
      allocs[term][week][day][time] ||= []
      allocs[term][week][day][time] << [type, course, room]
    end
    allocs
  end


  def self.find_optimal_answer(lines)
    last_line = -1
    lines.each_with_index do |l, i|
      if l =~ /Answer: \d+/
        last_line = i+1
      end
    end
    lines[last_line]
  end

  def self.import_allocations(year, allocs)
    allocs.each do |term_allocs|
      term_allocs[1].each do |week_allocs|
        week_allocs[1].each do |day_allocs|
          day_allocs[1].each do |slot|
            slot[1].each do |lecture|
              type = lecture[0]
              course_code = lecture[1]
              room_no = lecture[2]

              time_slot = Day.find_by_no(day_allocs[0]).time_slots.where(:start_hour => slot[0]).first
              week = year.terms.find_by_no(term_allocs[0]).weeks.find_by_no(week_allocs[0])
              course = year.lecture_courses.find_by_code(course_code)
              room = year.rooms.find_by_no(room_no)

              TimetableSlot.create!(:lecture_course => course, :room => room, :week => week, :time_slot => time_slot, :slot_type => type)
            end
          end
        end
      end
    end
  end
end
