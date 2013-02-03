class AddDefaultToMergedOnLectureCourse < ActiveRecord::Migration
  def up
    change_column :lecture_courses, :merged_lecturers, :boolean, :null => false, :default => false
  end

  def down
    change_column :lecture_courses, :merged_lecturers, :boolean, :null => true
  end
end
