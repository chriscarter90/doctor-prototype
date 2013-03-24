class RequirementImporterWorker
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
          degree_class = year.degree_classes.find_by_degreeyr(fields[1])
          unless lecture_course.nil? || degree_class.nil?
            requirement = lecture_course.requirements.where(:id => degree_class.id).first || lecture_course.requirements.build(:degree_class => degree_class)
            (2..(headers.length - 1)).each do |i|
              requirement.send("#{headers[i]}=", fields[i])
            end
            requirement.save!
          end
        end
      end
    end

    File.delete(full_filepath)
  end
end
