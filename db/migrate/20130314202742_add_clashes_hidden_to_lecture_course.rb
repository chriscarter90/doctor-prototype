class AddClashesHiddenToLectureCourse < ActiveRecord::Migration
  def change
    add_column :lecture_courses, :clashes_hidden, :boolean, :default => false
  end
end
