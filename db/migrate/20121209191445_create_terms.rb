class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.integer :year_id
      t.integer :no

      t.timestamps
    end

    add_index :terms, [:year_id, :no], :unique => true
  end
end
