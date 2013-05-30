class AddSizeToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :size, :string, :null => false, :default => "large"
  end
end
