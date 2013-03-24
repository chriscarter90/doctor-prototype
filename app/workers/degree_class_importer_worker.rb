class DegreeClassImporterWorker
  @queue = :importer_queue

  def self.perform(year_no, filename)
    year = Year.find_by_no(year_no)

    year.degree_classes.destroy_all

    full_filepath = Rails.root.join("tmp", filename)

    file = File.open(full_filepath) do |f|

      headers = []

      f.each_with_index do |line, index|
        if line =~ /\(\d+ rows?\)/
          break
        end

        line.gsub!(/\r\n/, '')
        fields = line.split("\t")
        fields[1] += fields.delete_at(2)
        if index == 0
          headers = fields
        else
          degree_class = year.degree_classes.find_by_degreeyr(fields[1]) || year.degree_classes.build
          fields.each_with_index do |f, i|
            degree_class.send("#{headers[i]}=", f)
          end
          degree_class.save!
        end
      end

    end

    File.delete(full_filepath)
  end
end
