class AddTypeToCourseWeek < ActiveRecord::Migration
  def change
    add_column :course_weeks, :session_type, :string
  end
end
