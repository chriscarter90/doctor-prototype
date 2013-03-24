class StaffMemberImporterWorker
  @queue = :importer_queue

  def self.perform(year_no, filename)
    year = Year.find_by_no(year_no)

    year.staff_members.destroy_all

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
          staff_member = year.staff_members.find_by_login(fields[0]) || year.staff_members.build
          fields.each_with_index do |f, i|
            staff_member.send("#{headers[i]}=", f)
          end
          staff_member.save!
        end
      end

    end

    File.delete(full_filepath)
  end
end
