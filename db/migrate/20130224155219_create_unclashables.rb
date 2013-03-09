class CreateUnclashables < ActiveRecord::Migration
  def change
    create_table :unclashables do |t|
      t.integer :year_id

      t.timestamps
    end
  end
end
