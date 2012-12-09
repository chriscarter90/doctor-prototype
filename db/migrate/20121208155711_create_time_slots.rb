class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :day_id
      t.integer :start_hour

      t.timestamps
    end

    add_index :time_slots, [:day_id, :start_hour], :unique => true
  end
end
