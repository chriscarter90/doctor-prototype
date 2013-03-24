class ChangeUniquenessOnRooms < ActiveRecord::Migration
  def up
    add_index :rooms, [:no, :year_id], :unique => true
  end

  def down
    remove_index :rooms, [:no, :year_id]
  end
end
