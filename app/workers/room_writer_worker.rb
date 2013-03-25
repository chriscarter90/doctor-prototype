class RoomWriterWorker
  @queue = :fact_writer_queue

  def self.perform(year_no)
    year = Year.find_by_no(year_no)

    models = Room.where(:year_id => year.id)

    File.open(Rails.root.join("ASP", year_no.to_s, "rooms.lp"), "w") do |f|
      models.each do |m|
        f.write("#{m.to_ASP}\n")
      end
    end
  end
end
