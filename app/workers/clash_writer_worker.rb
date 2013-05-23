class ClashWriterWorker
  @queue = :fact_writer_queue

  def self.perform(year_no)
    year = Year.find_by_no(year_no)

    File.open(Rails.root.join("ASP", year_no.to_s, "clashes.lp"), "w") do |f|
      year.clashes.each do |c|
        f.write("#{c.to_ASP}\n")
      end
    end
  end
end
