class AddTimetableGeneratedToYear < ActiveRecord::Migration
  def change
    add_column :years, :timetable_generated, :boolean, :default => false
  end
end
