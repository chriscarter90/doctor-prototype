class EditIndexOnLecturers < ActiveRecord::Migration
  def up
    remove_index :lecturers, [:lecture_course_id, :staff_member_id]
    add_index :lecturers, [:lecture_course_id, :staff_member_id, :role], :unique => true, :name => 'unique_lecturer'
  end

  def down
    remove_index  :lecturers, [:lecture_course_id, :staff_member_id, :role]
    add_index :lecturers, [:lecture_course_id, :staff_member_id], :unique => true
  end
end
