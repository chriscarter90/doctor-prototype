class ImporterWorker
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
          puts "Importing #{fields[0]}..."
          lecture_course = year.lecture_courses.find_by_code(fields[0]) || year.lecture_courses.build
          fields.each_with_index do |f, i|
            lecture_course.send("#{headers[i]}=", f)
          end
          lecture_course.save!
        end
      end
    end

    File.delete(full_filepath)
  end
end
