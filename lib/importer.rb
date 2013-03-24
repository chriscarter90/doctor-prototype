class Importer
  def self.import_classes
    file = File.open('db/seeds/class1213.tsv')

    headers = []

    file.each_with_index do |line, index|
      if line =~ /\(\d+ rows?\)/
        break
      end

      line.gsub!(/\r\n/, '')
      fields = line.split("\t")
      fields[1] += fields.delete_at(2)
      if index == 0
        headers = fields
      else
        degree_class = DegreeClass.find_by_degreeyr(fields[1]) || DegreeClass.new
        fields.each_with_index do |f, i|
          degree_class.send("#{headers[i]}=", f)
        end
        degree_class.save!
      end
    end
  end

  def self.import_staff
    file = File.open('db/seeds/teaching-staff1213.tsv')

    headers = []

    file.each_with_index do |line, index|
      if line =~ /\(\d+ rows?\)/
        break
      end

      line.gsub!(/\r\n/, '')
      fields = line.split("\t")
      if index == 0
        headers = fields
      else
        staff_member = StaffMember.find_by_login(fields[0]) || StaffMember.new
        fields.each_with_index do |f, i|
          staff_member.send("#{headers[i]}=", f)
        end
        staff_member.save!
      end
    end
  end

  def self.import_requirements
    file = File.open('db/seeds/xcourseclass1213.tsv')

    headers = []

    file.each_with_index do |line, index|
      if line =~ /\(\d+ rows?\)/
        break
      end

      line.gsub!(/\r\n/, '')
      fields = line.split("\t")
      if index == 0
        headers = fields
      else
        lecture_course = LectureCourse.find_by_code(fields[0])
        degree_class = DegreeClass.find_by_degreeyr(fields[1])
        requirement = lecture_course.requirements.where(:id => degree_class.id).first || Requirement.new(:lecture_course => lecture_course, :degree_class => degree_class)
        (2..(headers.length - 1)).each do |i|
          requirement.send("#{headers[i]}=", fields[i])
        end
        requirement.save!
      end
    end
  end

  def self.import_lecturers
    file = File.open('db/seeds/xcoursestaff1213.tsv')

    headers = []

    file.each_with_index do |line, index|
      if line =~ /\(\d+ rows?\)/
        break
      end

      line.gsub!(/\r\n/, '')
      fields = line.split("\t")
      if index == 0
        headers = fields
      else
        lecture_course = LectureCourse.find_by_code(fields[0])
        staff_member = StaffMember.find_by_login(fields[1])
        lecturer = lecture_course.lecturers.where(:staff_member_id => staff_member.id).where(:role => fields[2]).first || Lecturer.new(:lecture_course => lecture_course, :staff_member => staff_member, :role => fields[2])
        (3..(headers.length - 1)).each do |i|
          lecturer.send("#{headers[i]}=", fields[i])
        end
        lecturer.save!
      end
    end
  end
end
