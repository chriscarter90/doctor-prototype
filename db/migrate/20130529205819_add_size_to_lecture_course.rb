class AddSizeToLectureCourse < ActiveRecord::Migration
  def change
    add_column :lecture_courses, :size, :string
  end
end
