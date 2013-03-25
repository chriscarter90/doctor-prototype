class LectureCourseImporterWorker
  @queue = :importer_queue

  def self.perform(year_no, filename)
    year = Year.find_by_no(year_no)

    year.lecture_courses.destroy_all

    full_filepath = Rails.root.join("tmp", filename)

    file = File.open(full_filepath) do |f|

      headers = []

      f.each_with_index do |line, index|
        if line =~ /\(\d+ rows?\)/
          break
        end

        line.gsub!(/\r\n/, '')
        fields = line.split("\t")
        if index == 0
          headers = fields
        else
          lecture_course = year.lecture_courses.find_by_code(fields[0]) || year.lecture_courses.build
          fields.each_with_index do |f, i|
            lecture_course.send("#{headers[i]}=", f)
          end
          lecture_course.save!
        end
      end
    end

    File.delete(full_filepath)

    models = year.lecture_courses.by_code

    File.open(Rails.root.join("ASP", year_no.to_s, "lecture_courses.lp"), "w") do |f|
      models.each do |m|
        f.write("#{m.to_ASP}\n")
      end
    end

    File.open(Rails.root.join("ASP", year_no.to_s, "course_weeks.lp"), "w") do |f|
      models.each do |m|
        year.terms.each do |t|
          if m.taught_in_term?(t)
            f.write("per_week(\"#{m.code}\", 3, #{t.no}).\n")
          end
        end
      end
    end
  end
end
