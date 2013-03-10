class AddYearIdToDegreeClass < ActiveRecord::Migration
  def change
    add_column :degree_classes, :year_id, :integer
  end
end
