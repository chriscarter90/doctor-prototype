class CreateLectureCourseUnclashableJoinTable < ActiveRecord::Migration
  def change
    create_table :lecture_courses_unclashables do |t|
      t.integer :unclashable_id
      t.integer :lecture_course_id
    end
  end
end
