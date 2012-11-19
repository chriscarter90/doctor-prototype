class CreateStaffMembers < ActiveRecord::Migration
  def change
    create_table :staff_members do |t|
      t.string :login
      t.string :salutation
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end
end
