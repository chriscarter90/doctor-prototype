class AddMergeLecturersToLectureCourse < ActiveRecord::Migration
  def up
    add_column :lecture_courses, :merged_lecturers, :boolean
  end

  def down
    remove_column :lecture_courses, :merged_lecturers
  end
end
