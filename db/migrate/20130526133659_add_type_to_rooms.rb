class AddTypeToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :room_type, :string, :null => false, :default => "lecture"
  end
end
