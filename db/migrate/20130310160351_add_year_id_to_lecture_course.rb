class AddYearIdToLectureCourse < ActiveRecord::Migration
  def change
    add_column :lecture_courses, :year_id, :integer
  end
end
