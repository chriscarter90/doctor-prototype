class ChangeUniquenessOnStaffMembers < ActiveRecord::Migration
  def up
    add_index :staff_members, [:login, :year_id], :unique => true
  end

  def down
    remove_index :staff_members, [:login, :year_id]
  end
end
