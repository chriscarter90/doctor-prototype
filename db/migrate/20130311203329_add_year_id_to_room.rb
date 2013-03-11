class AddYearIdToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :year_id, :integer
  end
end
