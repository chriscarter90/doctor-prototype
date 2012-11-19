class CreateLectureCourses < ActiveRecord::Migration
  def change
    create_table :lecture_courses do |t|
      t.string :code
      t.string :title
      t.string :term
      t.string :classes
      t.integer :lecturehours
      t.integer :tutorialhours
      t.integer :labhours
      t.integer :weeklyhours
      t.integer :popestimate
      t.integer :popregistered

      t.timestamps
    end
  end
end
