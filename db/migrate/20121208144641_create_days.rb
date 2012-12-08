class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :no
      t.string :name

      t.timestamps
    end
  end
end
