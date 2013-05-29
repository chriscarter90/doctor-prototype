class CourseWeekWriterWorker
  @queue = :fact_writer_queue

  def self.perform(year_no)
    year = Year.find_by_no(year_no)

    File.open(Rails.root.join("ASP", year_no.to_s, "course_weeks.lp"), "w") do |f|
      year.course_weeks.each do |cw|
        f.write("#{cw.to_ASP}\n")
      end
    end

    File.open(Rails.root.join("ASP", year_no.to_s, "course_types.lp"), "w") do |f|
      year.lecture_courses.each do |c|
        f.write("#{c.type_to_ASP}")
      end
    end

    File.open(Rails.root.join("ASP", year_no.to_s, "course_sizes.lp"), "w") do |f|
      year.lecture_courses.each do |c|
        f.write("#{c.size_to_ASP}")
      end
    end
  end
end
