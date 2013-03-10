class AddYearIdToStaffMember < ActiveRecord::Migration
  def change
    add_column :staff_members, :year_id, :integer
  end
end
