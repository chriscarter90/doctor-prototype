class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.integer :no

      t.timestamps
    end
  end
end
