class CreateTimetableSlots < ActiveRecord::Migration
  def change
    create_table :timetable_slots do |t|
      t.integer :room_id
      t.integer :time_slot_id
      t.integer :lecture_course_id
      t.integer :week_id

      t.timestamps
    end

    add_index :timetable_slots, [:room_id, :time_slot_id, :week_id], :unique => true
  end
end
