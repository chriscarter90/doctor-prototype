class ChangeUniquenessOnDegreeClasses < ActiveRecord::Migration
  def up
    add_index :degree_classes, [:degreeyr, :year_id], :unique => true
  end

  def down
    remove_index :degree_classes, [:degreeyr, :year_id]
  end
end
