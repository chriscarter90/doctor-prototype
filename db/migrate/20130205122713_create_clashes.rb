class CreateClashes < ActiveRecord::Migration
  def change
    create_table :clashes do |t|
      t.integer :year_id

      t.timestamps
    end
  end
end
