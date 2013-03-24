class ChangeUniquenessOnLectureCourses < ActiveRecord::Migration
  def up
    add_index :lecture_courses, [:code, :year_id], :unique => true
  end

  def down
    remove_index :lecture_courses, [:code, :year_id]
  end
end
