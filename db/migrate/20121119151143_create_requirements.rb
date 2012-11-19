class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :lecture_course_id
      t.integer :degree_class_id
      t.string :required

      t.timestamps
    end

    add_index :requirements, [:lecture_course_id, :degree_class_id], :unique => true
  end
end
