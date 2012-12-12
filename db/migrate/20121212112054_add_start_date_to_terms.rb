class AddStartDateToTerms < ActiveRecord::Migration
  def up
    add_column :terms, :start_date, :date
  end

  def down
    remove_column :terms, :start_date
  end
end
