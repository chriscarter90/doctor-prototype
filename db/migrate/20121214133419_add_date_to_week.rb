class AddDateToWeek < ActiveRecord::Migration
  def up
    add_column :weeks, :date, :date
  end

  def down
    remove_column :weeks, :date
  end
end
