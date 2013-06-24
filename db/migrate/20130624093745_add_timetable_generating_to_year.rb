class AddTimetableGeneratingToYear < ActiveRecord::Migration
  def change
    add_column :years, :timetable_generating, :boolean, :default => false
  end
end
