class CreateDegreeClasses < ActiveRecord::Migration
  def change
    create_table :degree_classes do |t|
      t.string :degreeyr
      t.string :letteryr
      t.string :title

      t.timestamps
    end
  end
end
