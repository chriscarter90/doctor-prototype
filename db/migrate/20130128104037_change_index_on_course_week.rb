class ChangeIndexOnCourseWeek < ActiveRecord::Migration
  def up
    remove_index :course_weeks, :name => "as_week_lecture_course_staff_member"
    add_index :course_weeks, [:week_id, :lecture_course_id, :staff_member_id, :session_type], :name =>  "as_week_course_staff_type", :unique => true
  end

  def down
    remove_index :course_weeks, :name => "as_week_course_staff_type"
    add_index :course_weeks, [:week_id, :lecture_course_id, :staff_member_id], :name => "as_week_lecture_course_staff_member", :unique => true
  end
end
