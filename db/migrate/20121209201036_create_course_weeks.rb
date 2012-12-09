class CreateCourseWeeks < ActiveRecord::Migration
  def change
    create_table :course_weeks do |t|
      t.integer :week_id
      t.integer :lecture_course_id
      t.integer :staff_member_id

      t.timestamps
    end

    add_index :course_weeks, [:week_id, :lecture_course_id, :staff_member_id], :name => "as_week_lecture_course_staff_member", :unique => true
  end
end
