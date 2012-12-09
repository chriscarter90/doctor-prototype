class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :term_id
      t.integer :no

      t.timestamps
    end

    add_index :weeks, [:term_id, :no], :unique => true
  end
end
