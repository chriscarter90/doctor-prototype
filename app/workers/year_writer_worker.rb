class YearWriterWorker
  @queue = :fact_writer_queue

  def self.perform(year_no)
    year = Year.find_by_no(year_no)

    File.open(Rails.root.join("ASP", year_no.to_s, "terms.lp"), "w") do |f|
      year.terms.each do |t|
        f.write("#{t.to_ASP}\n")
      end
    end

    File.open(Rails.root.join("ASP", year_no.to_s, "weeks.lp"), "w") do |f|
      year.terms.each do |t|
        t.weeks.each do |w|
          f.write("#{w.to_ASP}\n")
        end
      end
    end
  end
end
