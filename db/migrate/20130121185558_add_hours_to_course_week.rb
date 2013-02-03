class AddHoursToCourseWeek < ActiveRecord::Migration
  def up
    add_column :course_weeks, :hours, :integer
  end

  def down
    remove_column :course_weeks, :hours
  end
end
