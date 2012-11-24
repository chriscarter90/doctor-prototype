class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :no
      t.integer :capacity

      t.timestamps
    end
  end
end
