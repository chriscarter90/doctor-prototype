class CreateClashes < ActiveRecord::Migration
  def change
    create_table :clashes do |t|
      t.integer :a_course_id
      t.integer :b_course_id
      t.integer :year_id

      t.timestamps
    end

    add_index :clashes, [:a_course_id, :b_course_id, :year_id], :unique => true
  end
end
