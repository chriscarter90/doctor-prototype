class CreateLecturers < ActiveRecord::Migration
  def change
    create_table :lecturers do |t|
      t.integer :lecture_course_id
      t.integer :staff_member_id
      t.string :role
      t.integer :staffhours
      t.string :term

      t.timestamps
    end

    add_index :lecturers, [:lecture_course_id, :staff_member_id], :unique => true
  end
end
