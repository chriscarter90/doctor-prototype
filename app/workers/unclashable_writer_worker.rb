class UnclashableWriterWorker
  @queue = :fact_writer_queue

  def self.perform(year_no)
    year = Year.find_by_no(year_no)

    models = year.unclashables

    File.open(Rails.root.join("ASP", year_no.to_s, "unclashables.lp"), "w") do |f|
      models.each do |m|
        f.write("#{m.to_ASP}")
      end
    end
  end
end
