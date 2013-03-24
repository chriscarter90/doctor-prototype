class LecturerImporterWorker
  @queue = :importer_queue

  def self.perform(year_no, filename)
    year = Year.find_by_no(year_no)

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
          lecture_course = year.lecture_courses.find_by_code(fields[0])
          staff_member = year.staff_members.find_by_login(fields[1])
          unless lecture_course.nil? || staff_member.nil?
            lecturer = lecture_course.lecturers.where(:staff_member_id => staff_member.id).where(:role => fields[2]).first || lecture_course.lecturers.build(:staff_member => staff_member, :role => fields[2])
            (3..(headers.length - 1)).each do |i|
              lecturer.send("#{headers[i]}=", fields[i])
            end
            lecturer.save!
          end
        end
      end
    end

    File.delete(full_filepath)
  end
end
