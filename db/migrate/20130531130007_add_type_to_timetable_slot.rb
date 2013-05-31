class AddTypeToTimetableSlot < ActiveRecord::Migration
  def change
    add_column :timetable_slots, :slot_type, :string, :null => false, :default => "lecture"
  end
end
