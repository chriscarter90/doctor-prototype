class CreateClashLectureCourseJoinTable < ActiveRecord::Migration
  def change
    create_table :clashes_lecture_courses do |t|
      t.integer :clash_id
      t.integer :lecture_course_id
    end
  end
end
