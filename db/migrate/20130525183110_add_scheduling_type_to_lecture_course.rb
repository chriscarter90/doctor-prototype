class AddSchedulingTypeToLectureCourse < ActiveRecord::Migration
  def change
    add_column :lecture_courses, :scheduling_type, :string
  end
end
